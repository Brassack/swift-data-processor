//
//  CALayer+UIColor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/23/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else{
                return UIColor.clear
            }
            return UIColor(cgColor: color)
        }
        
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
