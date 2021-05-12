//
//  QRCodeView.swift
//  CheckCheck
//
//  Created by Pavel Hollovic on 14.02.2021.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView : View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var url : String
    
    var body: some View {
        Image(uiImage: generateQRCode(from: url)).interpolation(.none).resizable().frame(width: 150, height: 150, alignment:.center)
    }
    
    func generateQRCode(from url: String) -> UIImage {
        let data = Data(url.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
