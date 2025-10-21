//
//  QRCode.swift
//  ios-qr-scanner
//
//  Created by James Chen on 21/10/25.
//

import UIKit
import CoreImage.CIFilterBuiltins

struct QRCode{
    let url: String
    let date: Date
    
    var generatedImage: UIImage? {
        let filter = CIFilter.qrCodeGenerator()
        
        filter.message = Data(url.utf8)
        filter.correctionLevel = "H"
        guard let outputCIImage = filter.outputImage else { return nil }
        
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = outputCIImage.transformed(by: transform)
        
        return UIImage(ciImage: scaledCIImage)
    }
}
