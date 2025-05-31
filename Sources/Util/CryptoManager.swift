//
//  CryptoHelper.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import Foundation
import CryptoKit

import Foundation
import CryptoKit
import CommonCrypto

struct CryptoManager {
    static func encrypt(message: String, password: String) -> (encryptedText: String, salt: String)? {
        do {
            let salt = generateSalt()
            let key = try deriveKey(password: password, salt: salt)
            
            let messageData = Data(message.utf8)
            let sealedBox = try AES.GCM.seal(messageData, using: key)
            
            // nonce + ciphertext + tag → 합친 후 base64 인코딩
            let combined = sealedBox.nonce + sealedBox.ciphertext + sealedBox.tag
            let encryptedText = combined.base64EncodedString()
            let base64Salt = salt.base64EncodedString()
            
            return (encryptedText, base64Salt)
        } catch {
            print("Encryption failed: \(error)")
            return nil
        }
    }

    static func decrypt(encryptedText: String, base64Salt: String, password: String) -> String? {
        do {
            // Step 1: salt 복원
            guard let salt = Data(base64Encoded: base64Salt) else { return nil }
            
            // Step 2: 키 유도
            let key = try deriveKey(password: password, salt: salt)
            
            // Step 3: 암호문 복원
            guard let combinedData = Data(base64Encoded: encryptedText) else { return nil }
            
            // AES-GCM 구성 요소 분리
            let nonceSize = 12
            let tagSize = 16
            guard combinedData.count > nonceSize + tagSize else { return nil }

            let nonce = try AES.GCM.Nonce(data: combinedData.prefix(nonceSize))
            let ciphertext = combinedData.dropFirst(nonceSize).dropLast(tagSize)
            let tag = combinedData.suffix(tagSize)
            
            let sealedBox = try AES.GCM.SealedBox(nonce: nonce, ciphertext: ciphertext, tag: tag)
            
            // 복호화
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("Decryption failed: \(error)")
            return nil
        }
    }

    
    static func generateSalt(length: Int = 16) -> Data {
        var salt = Data(count: length)
        let result = salt.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, length, $0.baseAddress!)
        }
        precondition(result == errSecSuccess, "Failed to generate salt")
        return salt
    }

    static func deriveKey(password: String, salt: Data, keySize: Int = 32, iterations: Int = 10000) throws -> SymmetricKey {
        let passwordData = Data(password.utf8)
        var key = Data(repeating: 0, count: keySize)
        
        let result = key.withUnsafeMutableBytes { keyBytes in
            salt.withUnsafeBytes { saltBytes in
                CCKeyDerivationPBKDF(
                    CCPBKDFAlgorithm(kCCPBKDF2),
                    password, passwordData.count,
                    saltBytes.baseAddress?.assumingMemoryBound(to: UInt8.self), salt.count,
                    CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256),
                    UInt32(iterations),
                    keyBytes.baseAddress?.assumingMemoryBound(to: UInt8.self), keySize
                )
            }
        }
        
        guard result == kCCSuccess else { throw NSError(domain: "PBKDF2Error", code: Int(result), userInfo: nil) }
        
        return SymmetricKey(data: key)
    }
}
