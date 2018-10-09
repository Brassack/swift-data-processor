//
//  UITextView+AssociatedObjects.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/2/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

extension UITextView {
    
    private struct OptionKeys {
        static var isHexEncoded = "is_hex_encoded"
        static var qrScannerSubscriber = "qr_scanner_subscriver"
    }
    
    @IBInspectable public var isHexEncodedData: Bool {
        get{
            return (objc_getAssociatedObject(self, &OptionKeys.isHexEncoded) as? Bool) ?? false
        }
        set{
            objc_setAssociatedObject(self, &OptionKeys.isHexEncoded, newValue as Bool?, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    internal var qrScannerSubscriber: SDPMapStoreSubscriberObject? {
        get{
            return objc_getAssociatedObject(self, &OptionKeys.qrScannerSubscriber) as? SDPMapStoreSubscriberObject
        }
        set{
            objc_setAssociatedObject(self, &OptionKeys.qrScannerSubscriber, newValue as SDPMapStoreSubscriberObject?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
