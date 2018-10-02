//
//  UITextView+HexEncodedOption.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/2/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

extension UITextField {
    
    private struct OptionKeys {
        static var isHexEncoded = "is_hex_encoded"
    }
    
    public var isHexEncodedData: Bool {
        get{
            return (objc_getAssociatedObject(self, &OptionKeys.isHexEncoded) as? Bool) ?? false
        }
        set{
            objc_setAssociatedObject(self, &OptionKeys.isHexEncoded, newValue as Bool?, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}
