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
            Text("ENCRYPTION")
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
                Text("QR 생성 실패")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}
