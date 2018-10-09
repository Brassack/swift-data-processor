//
// SDPSaltModuleInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPSaltModuleInteractor: SDPSaltModuleInteractorInput, StoreSubscriber {
    
    static let saltKey = "SDPSaltModuleInteractorSaltKey"
    weak var output: SDPSaltModuleInteractorOutput!
    var stores = SDPReduxStores.shared
    
    // MARK: SDPSaltModuleInteractorInput
    func requestData() {
        stores.mapStore.subscribe(self)
    }
    
    // MARK: StoreSubscriber
    func newState(state: SDPMapState) {
        
        guard let parameters = state.map[SDPEncryptionParametersVariables.encryptionParametersKey] as? SDPEncryptionParameters else {
            return
        }
        
        output.set(salt: parameters.salt)
    }
    
    func set(salt: String?) {
        
        guard var parameters = stores.mapStore.state.map[SDPEncryptionParametersVariables.encryptionParametersKey] as? SDPEncryptionParameters else {
            return
        }
        
        parameters.salt = salt
        
        let action = SDPMapStateWriteAction(key: SDPEncryptionParametersVariables.encryptionParametersKey, value: parameters)
        stores.mapStore.dispatch(action)
    }
}
