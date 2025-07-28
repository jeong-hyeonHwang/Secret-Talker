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
    private let qrManager = QRManager()
    
    var body: some View {
        VStack(spacing: 24) {
            Text(String(localized: "qr_title_encryption"))
                .font(.orbitronTitle2)
                .bold()
            
            if let uiImage = qrManager.generateQRCode(from: qrPayload) {
                Image(uiImage: uiImage)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 240, height: 240)
                    .padding()
            } else {
                Text(String(localized: "qr_error_generation_failed"))
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}
