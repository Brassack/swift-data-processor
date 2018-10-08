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
    var keySubscriber: SDPMapStoreSubscriberObject?

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
    
    func subscribeForQRClipboard() {
        
        let action = SDPMapStateWriteAction(key: SDPQRScannerModuleVariables.qrScannerWriteKey, value: SDPRawKeyModuleInteractor.rawKeyKey)
        stores.mapStore.dispatch(action)
        
        keySubscriber = SDPMapStoreSubscriberObject(mapStore: stores.mapStore, key: SDPRawKeyModuleInteractor.rawKeyKey, newStateBlock: { [weak self] (maybeText) in
            
            guard let text = maybeText as? String else {
                return
            }
            
            self?.output.setQRFinished()
            self?.keySubscriber = nil
            
            DispatchQueue.main.async {
                let action = SDPMapStateWriteAction(key: SDPRawKeyModuleInteractor.rawKeyKey, value: nil)
                self?.stores.mapStore.dispatch(action)
                
                if var parameters = self?.stores.mapStore.state.map[SDPEncryptionParametersVariables.encryptionParametersKey] as? SDPEncryptionParameters,
                    let key = Data(base64Encoded: text) {
                
                    parameters.rawKey = key
                    let action = SDPMapStateWriteAction(key: SDPEncryptionParametersVariables.encryptionParametersKey, value: parameters)
                    self?.stores.mapStore.dispatch(action)
                }
            }
        })
    }

    // MARK: StoreSubscriber
    func newState(state: SDPMapState) {
        guard let parameters = state.map[SDPEncryptionParametersVariables.encryptionParametersKey] as? SDPEncryptionParameters else {
            return
        }
        
        output.set(parameters: parameters)
    }
}
