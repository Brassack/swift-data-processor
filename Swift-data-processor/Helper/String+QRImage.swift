//
//  String+QRImage.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/26/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    func qrImage() -> UIImage? {
        
        guard let data = data(using: String.Encoding.utf8) else {
            return nil
        }
        
        let filter = CIFilter(name: "CIQRCodeGenerator")!
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("Q", forKey: "inputCorrectionLevel")
        
        guard let encodedImage: CIImage = filter.outputImage else {
            return nil
        }
        
        return UIImage(ciImage: encodedImage)
    }
}
