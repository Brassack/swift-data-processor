//
//  SDPSDPEncryptionSDPSDPEncryptionInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import ReSwift

class SDPEncryptionInteractor: SDPEncryptionInteractorInput, StoreSubscriber {

    weak var output: SDPEncryptionInteractorOutput!
    var stores = SDPReduxStores.shared
    
    // MARK: SDPQRGeneratorInteractorInput
    func requestClipboardData() {
        stores.mapStore.subscribe(self)
    }
    
    func setupParameters(withKeySize keySize: Int) {

        let parameters: SDPEncryptionParameters = (password: nil, salt: nil, keySize:keySize, computedRawKey: nil, rawKey: nil)
        
        let action = SDPMapStateWriteAction(key: SDPEncryptionVariables.encryptionParametersKey, value: parameters)
        stores.mapStore.dispatch(action)
    }
    
    // MARK: StoreSubscriber
    func newState(state: SDPMapState) {
        
        if let text = state.map["SDPEncryption"] as? String {
            
            output.set(text: text)
            let action = SDPMapStateWriteAction(key: "SDPEncryption", value: nil)
            stores.mapStore.dispatch(action)
        }
            
        if let parameters = state.map[SDPEncryptionVariables.encryptionParametersKey] as? SDPEncryptionParameters {
            
            output.set(parameters: parameters)
        }
    }
}
