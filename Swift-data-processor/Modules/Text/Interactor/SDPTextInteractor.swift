//
//  DPTexSDPTextInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPTextInteractor: SDPTextInteractorInput, StoreSubscriber {

    weak var output: SDPTextInteractorOutput!
    var data = (text:String?, range:NSRange?)(nil, nil)
    
    func newState(state: SDPTextClipboard) {
        guard let text = state.text else {
            return
        }
        
        SDPReduxStores.shared.clipboard.unsubscribe(self)
        output.textAddedToClipboard()
        data.text = text
        output.set(text: text)
        let action = SDPSetTextAction(string:nil)
        SDPReduxStores.shared.clipboard.dispatch(action)
    }
    
    func requestActions(){
        let actions = ["hash", "qr", "encryption", "escaping"]
        let titles = ["encryption": "Encryptions", "escaping":"XML/URL escaping", "hash":"Hashes", "qr":"To QR"]
        output.set(actions: actions, titles: titles)
    }
    
    func addTextToclipboard() {
        let action = SDPSetTextAction(string:data.text)
        SDPReduxStores.shared.clipboard.dispatch(action)
    }
    
    func set(text: String?) {
        data.text = text
    }
    
    func set(range: NSRange?) {
        data.range = range
    }

    func subscribeToClipboard() {
        SDPReduxStores.shared.clipboard.subscribe(self)
    }
    
    func unsubscribeFromClipboard() {
        SDPReduxStores.shared.clipboard.unsubscribe(self)
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
            
            if range.location >= pasteText.count {
                pasteText = "\(pasteText)\(string)"
            }else{
                let indexStartOfText = pasteText.index(pasteText.startIndex, offsetBy: range.location)
                let indexEndOfText = pasteText.index(indexStartOfText, offsetBy: range.length)
                pasteText.replaceSubrange(indexStartOfText..<indexEndOfText, with: string)
            }
            
            data.text = pasteText
            output.set(text: pasteText)
        }
    }

}
