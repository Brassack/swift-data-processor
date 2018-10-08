//
// SDPEncryptionInteractor.swift
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
    func requestData() {
        stores.mapStore.subscribe(self)
    }
    
    func setupParameters(isEncoding: Bool) {
        
        let parameters = SDPEncryptionParameters(password: nil,
                                                salt: nil,
                                                keySize: SDPCipherType.aes.defaultKeySize(),
                                                isEncoding: isEncoding,
                                                keyType: SDPEncryptionParametersModulePresenter.SDPEncryptionKeyType.passwordBased,
                                                method: SDPCipherType.aes,
                                                computedRawKey: nil,
                                                rawKey: nil)
        //: SDPEncryptionParameters = (password: nil, salt: nil, keySize:keySize, computedRawKey: nil, rawKey: nil)
        
        let action = SDPMapStateWriteAction(key: SDPEncryptionParametersVariables.encryptionParametersKey, value: parameters)
        stores.mapStore.dispatch(action)
    }
    
    //MARK: StoreSubscriber
    func newState(state: SDPMapState) {
        
        if let input = state.map["SDPEncryption"] as? SDPEncryptionInputParameters {
            
            if let text = input.text {
                output.set(text: text)
            }
            if let data = input.data {
                output.set(data: data)
            }
            
            let action = SDPMapStateWriteAction(key: "SDPEncryption", value: nil)
            stores.mapStore.dispatch(action)

            setupParameters(isEncoding: input.isEncoding)
        }
            
        if let parameters = state.map[SDPEncryptionParametersVariables.encryptionParametersKey] as? SDPEncryptionParameters {
            
            output.set(parameters: parameters)
        }
    }
    
    deinit {
        
        stores.mapStore.unsubscribe(self)
        let action = SDPMapStateWriteAction(key: SDPEncryptionParametersVariables.encryptionParametersKey, value: nil)
        stores.mapStore.dispatch(action)
    }
}
