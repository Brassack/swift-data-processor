//
//  SDPSDPPasswordBasedKeySDPSDPPasswordBasedKeyInteractor.swift
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
    
    var saltSubscriber: SDPMapStoreSubscriberObject?

    // MARK: SDPPasswordBasedKeyInteractorInput
    func subscribeForSaltClipboard() {
        
        let action = SDPMapStateWriteAction(key: SDPQRScannerVariables.qrScannerWriteKey, value: SDPPasswordBasedKeyInteractor.passwordKey)
        stores.mapStore.dispatch(action)
        
        saltSubscriber = SDPMapStoreSubscriberObject(mapStore: stores.mapStore, key: SDPPasswordBasedKeyInteractor.passwordKey, newStateBlock: { [weak self] (maybeText) in
            
            guard let text = maybeText as? String else {
                return
            }
            
            self?.output.setQRFinished()
            self?.saltSubscriber = nil
            
            DispatchQueue.main.async {
                let action = SDPMapStateWriteAction(key: SDPPasswordBasedKeyInteractor.passwordKey, value: nil)
                self?.stores.mapStore.dispatch(action)
                
                if var parameters = self?.stores.mapStore.state.map[SDPEncryptionVariables.encryptionParametersKey] as? SDPEncryptionParameters {
                    
                    parameters.password = text
                    let action = SDPMapStateWriteAction(key: SDPEncryptionVariables.encryptionParametersKey, value: parameters)
                    self?.stores.mapStore.dispatch(action)
                }
            }
        })
    }
    
    func requestData() {
        stores.mapStore.subscribe(self)
    }
    
    func set(parameters: SDPEncryptionParameters?) {
        
        let action = SDPMapStateWriteAction(key: SDPEncryptionVariables.encryptionParametersKey, value: parameters)
        stores.mapStore.dispatch(action)
    }
    
    // MARK: StoreSubscriber
    func newState(state: SDPMapState) {
        guard var parameters = state.map[SDPEncryptionVariables.encryptionParametersKey] as? SDPEncryptionParameters else {
            return
        }
        
        output.set(parameters: parameters)
        
        guard let password = parameters.password, password.count > 0 else {
            
            if parameters.computedRawKey != nil {
                
                parameters.computedRawKey = nil
                let action = SDPMapStateWriteAction(key: SDPEncryptionVariables.encryptionParametersKey, value: parameters)
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
                let action = SDPMapStateWriteAction(key: SDPEncryptionVariables.encryptionParametersKey, value: parameters)
                stores.mapStore.dispatch(action)
            }
            
        }catch{
            //TODO: Handle
        }
    }
    
}
