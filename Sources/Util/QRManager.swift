//
//  QRGenerator.swift
//  SecretTalker
//
//  Created by 황정현 on 7/28/25.
//

import UIKit
import CoreImage.CIFilterBuiltins

final class QRManager {
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()

    func generateQRCode(from payload: QRMessagePayload) -> UIImage? {
        guard let data = try? JSONEncoder().encode(payload) else {
            print("QR 인코딩 실패")
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")

        if let output = filter.outputImage,
           let cgimg = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgimg)
        }

        return nil
    }
}
