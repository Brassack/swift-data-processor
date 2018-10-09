//
// SDPRawKeyModuleInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPRawKeyModuleInteractor: SDPRawKeyModuleInteractorInput, StoreSubscriber {
    
    static let rawKeyKey = "SDPRawdKeyInteractorKey"

    weak var output: SDPRawKeyModuleInteractorOutput!
    
    var stores = SDPReduxStores.shared

    // MARK: SDPPasswordBasedKeyInteractorInput
    func requestData() {
        stores.mapStore.subscribe(self)
    }
    
    func set(key: Data?) {
        
        if var parameters = stores.mapStore.state.map[SDPEncryptionParametersVariables.encryptionParametersKey] as? SDPEncryptionParameters {
            
            parameters.rawKey = key
            let action = SDPMapStateWriteAction(key: SDPEncryptionParametersVariables.encryptionParametersKey, value: parameters)
            stores.mapStore.dispatch(action)
        }
    }
    
   
    // MARK: StoreSubscriber
    func newState(state: SDPMapState) {
        guard let parameters = state.map[SDPEncryptionParametersVariables.encryptionParametersKey] as? SDPEncryptionParameters else {
            return
        }
        
        output.set(parameters: parameters)
    }
}
