//
//  DPTexSDPTextInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift


class SDPTextModuleInteractor: SDPTextModuleInteractorInput {
    
    typealias SDPTextActionItem = (idx: String, title: String, validate: (() -> (isValid: Bool, invalidReason: String?))?, preparation: (() -> Bool))

    static let scannedText = "scannedText"
    
    weak var output: SDPTextModuleInteractorOutput!
    var data = (text:String?, range:NSRange?)(nil, nil)
    var stores = SDPReduxStores.shared
    var clipboardSubscriber:SDPMapStoreSubscriberObject?
    
    
    func requestActions(){
        
        let hashesAction = SDPTextActionItem(idx: "SDPHashes", title: "Hashes", validate: nil, preparation: { [weak self] () -> Bool in
            guard let text = self?.data.text else {
                return false
            }
            self?.addToClipboard(parameters: text, forAction: "SDPHashes")
            return true
        })
        
        let qrAction = SDPTextActionItem(idx: "SDPQRGenerator", title: "To QR", validate: { [weak self] () -> (isValid: Bool, invalidReason: String?) in
            
            guard let text = self?.data.text else {
                return (false, "No text")
            }
            
            if text.count > 1024 {
                return (false, "Too long for QR (max 1024)")
            }
            
            return (true, nil)
        }, preparation: { [weak self] () in
            
            guard let text = self?.data.text else {
                return false
            }
            
            self?.addToClipboard(parameters: text, forAction: "SDPQRGenerator")
            return true
        })
        
        let encryptionAction = SDPTextActionItem(idx: "SDPEncryption", title: "Encryption", validate: nil, preparation: { [weak self] () in
                
            guard let text = self?.data.text else {
                return false
            }
            
            let parameters: SDPEncryptionInputParameters = (text: text, data: nil, isEncoding: true)
            self?.addToClipboard(parameters:parameters , forAction: "SDPEncryption")
            return true
        })
        
        let decryptionAction = SDPTextActionItem(idx: "SDPEncryption", title: "Decryption", validate: { [weak self] () -> (isValid: Bool, invalidReason: String?) in
            
                guard let text = self?.data.text else {
                    return (false, "No text")
                }
            
                guard Data(base64Encoded: text) != nil else {
                    return (false, "We support only base64 encoded data")
                }
            
                return (true, nil)
            }, preparation: { [weak self] () in
            
                guard let text = self?.data.text else {
                    return false
                }
                
                guard let data = Data(base64Encoded: text) else {
                    return false
                }
            
                let parameters: SDPEncryptionInputParameters = (text: nil, data: data, isEncoding: false)

                self?.addToClipboard(parameters: parameters, forAction: "SDPEncryption")
            return true
        })

        //
        
        let escapingAction = SDPTextActionItem(idx: "SDPEscaping", title: "URL/HTML escaping", validate: nil, preparation: { [weak self] () in
                
                guard let text = self?.data.text else {
                    return false
                }
                
                self?.addToClipboard(parameters: text, forAction: "SDPEscaping")
                return true
        })
        let actions = [qrAction, hashesAction, encryptionAction, decryptionAction, escapingAction]
        output.set(actions: actions)
    }

    func addToClipboard(parameters: Any, forAction action:String) {
        
        let action = SDPMapStateWriteAction(key: action, value: parameters)//SDPSetTextAction(string:data.text)
        stores.mapStore.dispatch(action)
    }
    
    func addTextToclipboard(action:String) {
        let action = SDPMapStateWriteAction(key: action, value: data.text)//SDPSetTextAction(string:data.text)
        stores.mapStore.dispatch(action)
    }
    
    func set(text: String?) {
        data.text = text
    }
    
    func set(range: NSRange?) {
        data.range = range
    }

    func subscribeToClipboard() {
        
        let action = SDPMapStateWriteAction(key: SDPQRScannerVariables.qrScannerWriteKey, value: SDPTextModuleInteractor.scannedText)
        stores.mapStore.dispatch(action)
        
        clipboardSubscriber = SDPMapStoreSubscriberObject(mapStore: stores.mapStore, key: SDPTextModuleInteractor.scannedText, newStateBlock: { [weak self](maybeText) in
            
            guard let text = maybeText as? String else {
                return
            }
            
            self?.output.textAddedToClipboard()
            self?.data.text = text
            self?.output.set(text: text)
            
            self?.clipboardSubscriber = nil
            
            DispatchQueue.main.async {
                let action = SDPMapStateWriteAction(key: SDPHashesInteractor.saltKey, value: nil)
                self?.stores.mapStore.dispatch(action)
            }
            
        })
    }
    
    func unsubscribeFromClipboard() {
        clipboardSubscriber = nil
    }
    
    func copy() {
        
        guard let text = data.text else {
            return
        }
        
        var isNoValidRange = data.range == nil
        
        if !isNoValidRange, let range = data.range {
            isNoValidRange = range.length == 0 || (range.location + range.length) > text.count || range.location < 0
        }
        
        if isNoValidRange {
            print("copy \(text)")
            UIPasteboard.general.string = text
            
        }else if let range = data.range {
            
            let indexStartOfText = text.index(text.startIndex, offsetBy: range.location)
            let indexEndOfText = text.index(indexStartOfText, offsetBy: range.length)
            
            let string = String(text[indexStartOfText..<indexEndOfText])
            print("copy \(string)")
            UIPasteboard.general.string = string
        }
        
    }
    
    func paste() {
        
        guard let string = UIPasteboard.general.string else {
            return
        }
        
        var isNoValidRange = data.range == nil
        
        if !isNoValidRange, let range = data.range {
            isNoValidRange = range.location < 0
            
            if !isNoValidRange, let text = data.text {
                isNoValidRange = (range.location + range.length) > text.count
            }
        }
        
        if isNoValidRange {
            data.text = string
            output.set(text: string)
            
        }else if let range = data.range {
            
            var pasteText = data.text ?? ""

            let indexStartOfText = pasteText.index(pasteText.startIndex, offsetBy: range.location)
            let indexEndOfText = pasteText.index(indexStartOfText, offsetBy: range.length)
            pasteText.replaceSubrange(indexStartOfText..<indexEndOfText, with: string)
            
            data.text = pasteText
            output.set(text: pasteText)
        }
    }

}
