//
//  SDPSDPSaltModuleSDPSDPSaltModuleInteractor.swift
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
    var saltSubscriber: SDPMapStoreSubscriberObject?
    
    // MARK: SDPSaltModuleInteractorInput
    func requestData() {
        stores.mapStore.subscribe(self)
    }
    
    // MARK: StoreSubscriber
    func newState(state: SDPMapState) {
        
        guard let parameters = state.map[SDPEncryptionVariables.encryptionParametersKey] as? SDPEncryptionParameters else {
            return
        }
        
        output.set(salt: parameters.salt)
    }
    
    
    func subscribeForSaltClipboard() {
        
        let action = SDPMapStateWriteAction(key: SDPQRScannerModuleVariables.qrScannerWriteKey, value: SDPSaltModuleInteractor.saltKey)
        stores.mapStore.dispatch(action)
        
        saltSubscriber = SDPMapStoreSubscriberObject(mapStore: stores.mapStore, key: SDPSaltModuleInteractor.saltKey, newStateBlock: { [weak self] (maybeText) in
            
            guard let text = maybeText as? String else {
                return
            }

            self?.output.setQRFinished()
            self?.saltSubscriber = nil
            


            
            DispatchQueue.main.async {
                let action = SDPMapStateWriteAction(key: SDPSaltModuleInteractor.saltKey, value: nil)
                self?.stores.mapStore.dispatch(action)
                
                if var parameters = self?.stores.mapStore.state.map[SDPEncryptionVariables.encryptionParametersKey] as? SDPEncryptionParameters {
                    
                    parameters.salt = text
                    let action = SDPMapStateWriteAction(key: SDPEncryptionVariables.encryptionParametersKey, value: parameters)
                    self?.stores.mapStore.dispatch(action)
                }
            }
        })
    }
    
    func set(salt: String?) {
        
        guard var parameters = stores.mapStore.state.map[SDPEncryptionVariables.encryptionParametersKey] as? SDPEncryptionParameters else {
            return
        }
        
        parameters.salt = salt
        
        let action = SDPMapStateWriteAction(key: SDPEncryptionVariables.encryptionParametersKey, value: parameters)
        stores.mapStore.dispatch(action)
    }
}
