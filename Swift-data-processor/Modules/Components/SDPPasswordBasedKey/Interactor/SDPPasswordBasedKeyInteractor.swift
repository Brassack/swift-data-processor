//
// SDPPasswordBasedKeyInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPPasswordBasedKeyInteractor: SDPPasswordBasedKeyInteractorInput, StoreSubscriber {

    static let passwordKey = "SDPPasswordBasedKeyInteractorPassword"
    
    weak var output: SDPPasswordBasedKeyInteractorOutput!
    var stores = SDPReduxStores.shared    

    // MARK: SDPPasswordBasedKeyInteractorInput
    func requestData() {
        stores.mapStore.subscribe(self)
    }
    
    func set(parameters: SDPEncryptionParameters?) {
        
        let action = SDPMapStateWriteAction(key: SDPEncryptionParametersVariables.encryptionParametersKey, value: parameters)
        stores.mapStore.dispatch(action)
    }
    
    // MARK: StoreSubscriber
    func newState(state: SDPMapState) {
        guard var parameters = state.map[SDPEncryptionParametersVariables.encryptionParametersKey] as? SDPEncryptionParameters else {
            return
        }
        
        output.set(parameters: parameters)
        
        guard let password = parameters.password, password.count > 0 else {
            
            if parameters.computedRawKey != nil {
                
                parameters.computedRawKey = nil
                let action = SDPMapStateWriteAction(key: SDPEncryptionParametersVariables.encryptionParametersKey, value: parameters)
                stores.mapStore.dispatch(action)
            }
            return
        }
        
        do{
            var key: Data?
            if let salt = parameters.salt {
                key = try SDPEncryptionKeyGenerator.makeKey(password: password, salt: salt, keySize: parameters.keySize)
            }else{
                key = try SDPEncryptionKeyGenerator.makeKey(password: password, keySize: parameters.keySize)
            }
            
            if key != parameters.computedRawKey {
                
                parameters.computedRawKey = key
                let action = SDPMapStateWriteAction(key: SDPEncryptionParametersVariables.encryptionParametersKey, value: parameters)
                stores.mapStore.dispatch(action)
            }
            
        }catch{
            //TODO: Handle
        }
    }
    
}
