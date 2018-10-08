//
//  DPSDPEncryptionParametersModuleInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 08/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPEncryptionParametersModuleInteractor: SDPEncryptionParametersModuleInteractorInput, StoreSubscriber {

    weak var output: SDPEncryptionParametersModuleInteractorOutput!
    var stores = SDPReduxStores.shared

    //MARK: StoreSubscriber
    func newState(state: SDPMapState) {
        if let parameters = state.map[SDPEncryptionParametersVariables.encryptionParametersKey] as? SDPEncryptionParameters {
            
            output.set(parameters: parameters)
        }
    }
    
    func requestParameters() {
        
        stores.mapStore.subscribe(self)
    }
    
    func update(parameters: SDPEncryptionParameters?) {
        
        let action = SDPMapStateWriteAction(key: SDPEncryptionParametersVariables.encryptionParametersKey, value: parameters)
        stores.mapStore.dispatch(action)
    }
}
