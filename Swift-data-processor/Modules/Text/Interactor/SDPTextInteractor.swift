//
//  DPTexSDPTextInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPTextInteractor: SDPTextInteractorInput {

    static let scannedText = "scannedText"
    
    weak var output: SDPTextInteractorOutput!
    var data = (text:String?, range:NSRange?)(nil, nil)
    var stores = SDPReduxStores.shared
    var clipboardSubscriber:SDPMapStoreSubscriberObject?
    
    
    func requestActions(){
        let actions = ["SDPHashes", "SDPQRGenerator", "encryption", "escaping"]
        let titles = ["encryption": "Encryptions", "escaping":"XML/URL escaping", "SDPHashes":"Hashes", "SDPQRGenerator":"To QR"]
        output.set(actions: actions, titles: titles)
    }
    
    func requestValidationForQRGenerator(){
        
        output.textForQR(valid: (data.text?.count ?? 0) <= 1024) 
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
        
        let action = SDPMapStateWriteAction(key: SDPQRScannerVariables.qrScannerWriteKey, value: SDPTextInteractor.scannedText)
        stores.mapStore.dispatch(action)
        
        clipboardSubscriber = SDPMapStoreSubscriberObject(mapStore: stores.mapStore, key: SDPTextInteractor.scannedText, newStateBlock: { [weak self](maybeText) in
            
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
