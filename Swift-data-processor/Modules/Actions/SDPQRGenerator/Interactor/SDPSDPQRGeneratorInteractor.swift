//
//  SDPSDPQRGeneratorSDPSDPQRGeneratorInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPQRGeneratorInteractor: SDPQRGeneratorInteractorInput, StoreSubscriber {

    weak var output: SDPQRGeneratorInteractorOutput!
    var stores = SDPReduxStores.shared

    // MARK: SDPQRGeneratorInteractorInput
    func requestClipboardData() {
        stores.clipboard.subscribe(self)
    }
    
    // MARK: StoreSubscriber
    func newState(state: SDPTextClipboard) {
        guard let text = state.text else {
            return
        }
        
        stores.clipboard.unsubscribe(self)
        output.set(text: text)
        let action = SDPSetTextAction(string:nil)
        stores.clipboard.dispatch(action)
    }
}
