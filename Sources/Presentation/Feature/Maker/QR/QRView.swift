//
//  QRView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRView: View {
    let qrPayload: QRMessagePayload

    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()

    var body: some View {
        VStack(spacing: 24) {
            Text("ENCRYPTION")
                .font(.orbitronTitle2)
                .bold()

            if let uiImage = generateQRCode(from: qrPayload) {
                Image(uiImage: uiImage)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 240, height: 240)
                    .padding()
            } else {
                Text("QR 생성 실패")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }

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
