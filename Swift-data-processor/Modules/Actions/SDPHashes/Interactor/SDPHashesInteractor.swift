//
// SDPHashesInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift


class SDPHashesInteractor: SDPHashesInteractorInput, StoreSubscriber {

    static let saltKey: String = "SDPHashesSalt"
    static let argon2Key: String = "SDPHashesArgon2"

    weak var output: SDPHashesInteractorOutput!
    var hashesDataFactory: SDPHashesTableViewDataFactory?
    var text: String?
    
    private var hashParameters: (iterations: Int, salt: String?) = (iterations: 1, salt: nil)
    private var argon2Parameters: SDPArgon2Parameters = (hashLength: argon2DefaultHashLength, memory:argon2DefaultMemory, parallelism: argon2DefaultParallelism)
    
    var stores = SDPReduxStores.shared
    
    private var saltSubscriber: SDPMapStoreSubscriberObject?
    private var argon2ParametersSubscriber: SDPMapStoreSubscriberObject?
    
    
    // MARK: StoreSubscriber
    func newState(state: SDPMapState) {
        
        guard let text = state.map["SDPHashes"] as? String else {
            return
        }
        
        self.text = text
        stores.mapStore.unsubscribe(self)
        updateData()
        let action = SDPMapStateWriteAction(key: "SDPHashes", value: nil)
        stores.mapStore.dispatch(action)
    }
    
    // MARK: SDPHashesInteractorInput
    func unsubscribeFromSaltClipboard() {
        saltSubscriber = nil
    }
    
    func unsubscribeFromArgon2Clipboard() {
        argon2ParametersSubscriber = nil
    }
    
    func subscribeForSaltClipboard() {
        
        let action = SDPMapStateWriteAction(key: SDPQRScannerModuleVariables.qrScannerWriteKey, value: SDPHashesInteractor.saltKey)
        stores.mapStore.dispatch(action)
        
        saltSubscriber = SDPMapStoreSubscriberObject(mapStore: stores.mapStore, key: SDPHashesInteractor.saltKey, newStateBlock: { [weak self] (maybeText) in
            
            guard let text = maybeText as? String else {
                return
            }
            
            self?.output.setScanned(salt: text)
            self?.saltSubscriber = nil
            
            DispatchQueue.main.async {
                let action = SDPMapStateWriteAction(key: SDPHashesInteractor.saltKey, value: nil)
                self?.stores.mapStore.dispatch(action)
            }
        })
    }
    
    func setupAndSubscripeToArgon2Parameters() {
        
        let action = SDPMapStateWriteAction(key: SDPArgon2ParametersPopupVariables.argon2ParametersPopupWriteKey, value: SDPHashesInteractor.argon2Key)
        stores.mapStore.dispatch(action)
        
        let setParametersAction = SDPMapStateWriteAction(key: "SDPArgon2ParametersPopup", value: argon2Parameters)
        stores.mapStore.dispatch(setParametersAction)
        
        
        argon2ParametersSubscriber = SDPMapStoreSubscriberObject(mapStore: stores.mapStore, key: SDPHashesInteractor.argon2Key, newStateBlock: { [weak self] (maybeParameters) in
            
            guard let argon2Parameters = maybeParameters as? SDPArgon2Parameters else {
                return
            }
            
            self?.argon2Parameters = argon2Parameters
            self?.argon2ParametersSubscriber = nil
            
            DispatchQueue.main.async {
                let action = SDPMapStateWriteAction(key: SDPHashesInteractor.argon2Key, value: nil)
                self?.stores.mapStore.dispatch(action)
            }
            
            guard let parameters = self?.hashParameters else{
                return
            }
            
            self?.requestData(parameters)

        })
        
    }

    func requestData(_ parameters:(iterations: Int, salt: String?)) {
        
        hashParameters = parameters
        if self.text == nil {
            stores.mapStore.subscribe(self)
        }else{
            updateData()
        }
    }
    
    // MARK: Private
    private func updateData(){
        
        guard let text = text else {
            return
        }
        
        guard hashesDataFactory == nil
            || hashesDataFactory?.iterations != hashParameters.iterations
            || hashesDataFactory?.salt != hashParameters.salt
            || hashesDataFactory?.argon2HashLength != argon2Parameters.hashLength
            || hashesDataFactory?.argon2Memory != argon2Parameters.memory
            || hashesDataFactory?.argon2Parallelism != argon2Parameters.parallelism else{
            return
        }
        
        hashesDataFactory = SDPHashesTableViewDataFactory(text: text, delegate: output)
        
        hashesDataFactory?.iterations = hashParameters.iterations
        hashesDataFactory?.salt = hashParameters.salt
        
        hashesDataFactory?.argon2HashLength = argon2Parameters.hashLength
        hashesDataFactory?.argon2Memory = argon2Parameters.memory
        hashesDataFactory?.argon2Parallelism = argon2Parameters.parallelism
        
        hashesDataFactory?.createData()
    }
}
