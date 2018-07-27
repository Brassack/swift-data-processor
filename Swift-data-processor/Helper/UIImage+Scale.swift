//
//  UIImage+Scale.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/26/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

extension UIImage {
    
    func scaled(to:CGSize) -> UIImage?{
        
        if size != to {
            //cgImage
            //If the UIImage object was initialized using a CIImage object, the value of the property is NULL.
            //ciImage
            //If the UIImage object was initialized using a CGImage, the value of the property is nil.
            
            
            var forcedCGImage = cgImage
            
            if forcedCGImage == nil, let ciImage = ciImage {
                forcedCGImage = CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent)
            }
            
            guard let cgImage = forcedCGImage else {
                return nil
            }
            
            UIGraphicsBeginImageContextWithOptions(to, true, 0)
            
            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }
            
            context.interpolationQuality = .none
            context.translateBy(x: 0, y: to.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.draw(cgImage, in: context.boundingBoxOfClipPath)
            let result = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            return result
        }
        
        return self
    }
}
