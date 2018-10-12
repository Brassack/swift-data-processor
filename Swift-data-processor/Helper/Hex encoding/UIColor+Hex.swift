//
//  UIColor+Hex.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/24/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit


extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: Int) {
        self.init(red: CGFloat(red)/255.0,
                  green: CGFloat(green)/255.0,
                  blue: CGFloat(blue)/255.0,
                  alpha: CGFloat(alpha)/255.0)
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            alpha: 255
        )
    }
    
    var hexValue:Int {
        get{
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            getRed(&r, green: &g, blue: &b, alpha: &a)
            
            return (Int)(r*255)<<16 |
                (Int)(g*255)<<8 |
                (Int)(b*255)<<0
        }
    }
}
