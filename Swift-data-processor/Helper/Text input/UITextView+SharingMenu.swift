//
//  UITextView+QRSharing.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/1/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

extension UITextView {
    
    @objc func _canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if isHexEncodedData {
            
            if action == #selector(shareBinary) {
                return text.count > 0
            }
            
            if action == #selector(createQR) {
                return false
            }
        }else{
            
            if action == #selector(createQR) {
                return text.count > 0
            }
            
            if action == #selector(shareBinary) {
                return false
            }
        }

        return _canPerformAction(action,  withSender:sender)
    }
    
    @objc func createQR() {
        
        if let range = selectedTextRange, range.start != range.end {
            
            guard let string = self.text(in:range) else {
                return
            }
            
            SDPSharingPresenter().qrSharePrepareDataAndPresentInRootController(text: string)
            
        }else if let string = text {
            
            SDPSharingPresenter().qrSharePrepareDataAndPresentInRootController(text: string)
        }
    }
    
    
    @objc func shareBinary() {
        
        guard let text = text, text.count > 0 else {
            return
        }
        guard let data = text.hexDecodedData() else {
            return
        }
        
        SDPSharingPresenter().share(data: data)

    }
}
