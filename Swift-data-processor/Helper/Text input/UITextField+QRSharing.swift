//
//  UITextField.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/1/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit
import ReSwift

extension UITextField {
    
    @objc func _canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(createQR) {
            return text?.count ?? 0 > 0
        }
        return _canPerformAction(action,  withSender:sender)
    }
    
    @objc func createQR() {
    
        if let range = selectedTextRange, range.start != range.end {
            
            guard let string = self.text(in:range) else {
                return
            }
            
            SDPQRSharingPresenter().prepareDataAndPresentInRootController(text: string)
            
        }else if let string = text {
            
            SDPQRSharingPresenter().prepareDataAndPresentInRootController(text: string)
        }
    }
}
