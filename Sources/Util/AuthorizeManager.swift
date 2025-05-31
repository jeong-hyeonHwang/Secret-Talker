//
//  AuthorizeManager.swift
//  SecretTalker
//
//  Created by 황정현 on 7/10/25.
//

import Combine
import LocalAuthentication

@MainActor
final class AuthorizeManager: ObservableObject {
    @Published var isAuthenticated: Bool? = nil

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "암호화된 메시지를 보기 위해 Face ID 인증이 필요합니다."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    self.isAuthenticated = success
                }
            }
        } else {
            print("Face ID 사용 불가: \(error?.localizedDescription ?? "Unknown error")")
            self.isAuthenticated = false
        }
    }
}
