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
        
        if action == #selector(_share) {
            return false
        }

        var rootVC = UIApplication.shared.keyWindow?.rootViewController
        while let presented = rootVC?.presentedViewController {
            rootVC = presented
        }
        
        let isAlertPresented = rootVC is UIAlertController

        if isAlertPresented, action == #selector(qrScan) {
            return false
        }
        
        if isHexEncodedData {
            
            if action == #selector(shareBinary) {
                
                guard let text = text else {
                    return false
                }
                if !(text.count > 0) {
                    return false
                }
                if let range = selectedTextRange, range.start != range.end {
                    
                    guard let string = self.text(in:range) else {
                        return false
                    }
                    return string.isHexEncodedData
                }else{
                    
                    return text.isHexEncodedData
                }
            }
            
            if action == #selector(share) {
                return false
            }
        }else{
            
            if action == #selector(share) {
                return (text?.count ?? 0) > 0
            }
            
            if action == #selector(shareBinary) {
                return false
            }
        }
        
        return _canPerformAction(action,  withSender:sender)
    }

    @objc func shareBinary() {
        
        guard let text = text, text.count > 0 else {
            return
        }
        
        if let range = selectedTextRange, range.start != range.end {
            
            guard let string = self.text(in:range) else {
                return
            }
            guard string.isHexEncodedData else {
                return
            }
            guard let data = string.hexDecodedData() else {
                return
            }
            
            SDPSharingPresenter().share(data: data)
        }else{
            
            guard text.isHexEncodedData else {
                return
            }
            guard let data = text.hexDecodedData() else {
                return
            }
            
            SDPSharingPresenter().share(data: data)
        }
    }
    
    @objc func qrScan() {
        
        let uuid = UUID().uuidString
        
        let store = SDPReduxStores.shared.mapStore
        let action = SDPMapStateWriteAction(key: SDPQRScannerModuleVariables.qrScannerWriteKey, value: uuid)
        
        store.dispatch(action)
        
        guard var rootVC = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        while let presented = rootVC.presentedViewController {
            rootVC = presented
        }
        
        let vc = UIStoryboard.components.instantiateViewController(withIdentifier: String(describing: SDPQRScannerModuleViewController.self))
        
        if let vc = vc as? SDPViewExternalConfiguratorProtocol{
            vc.externalConfigurator = SDPQRScannerModuleViewDismissButtonExternalConfigurator()
        }
        
        let nc = UINavigationController.init(rootViewController: vc)
        
        weak var weakNC = nc
        qrScannerSubscriber = SDPMapStoreSubscriberObject(mapStore: store, key: uuid, newStateBlock: { [weak self] (replacementText) in
            
            weakNC?.dismissFromParentAnimated()
            
            self?.qrScannerSubscriber?.invalidate()
            self?.qrScannerSubscriber = nil
            
            guard let replacementText = replacementText as? String,
                let sself = self,
                let text = sself.text
                else{
                    return
            }
            
            if self?.delegate?.textField?(sself, shouldChangeCharactersIn:  NSRange(location: 0, length: text.count), replacementString: replacementText) ?? true {
                
                self?.delegate?.textFieldDidBeginEditing?(sself)
                self?.text = replacementText
                self?.delegate?.textFieldDidEndEditing?(sself)
            }
        })
        
        rootVC.present(nc, animated: true, completion: nil)
    }
    
    @objc func _share(_:Any){}
    
    @objc func share() {
        if let range = selectedTextRange, range.start != range.end {
            
            guard let string = self.text(in:range) else {
                return
            }
            
            SDPSharingPresenter().share(string: string)
        }else if let string = text {
            
            SDPSharingPresenter().share(string: string)
        }
    }
}
