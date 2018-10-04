//
//  DPQRScannerDPQRScannerInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 19/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPQRScannerModuleInteractor: SDPQRScannerModuleInteractorInput, StoreSubscriber {
    

    weak var output: SDPQRScannerModuleInteractorOutput!
    var stores = SDPReduxStores.shared
    var qrWriteKey: Any?
    
    init() {
        stores.mapStore.subscribe(self)
    }
    
    func newState(state: SDPMapState) {
        
        guard let key = state.map[SDPQRScannerModuleVariables.qrScannerWriteKey]  else {
            return
        }
        
        qrWriteKey = key
        stores.mapStore.unsubscribe(self)
    }
    
    
    func textReady(_ text: String) {
        
        guard let qrWriteKey = qrWriteKey as? AnyHashable else {
            return
        }
        
        let action = SDPMapStateWriteAction(key: qrWriteKey, value: text)
        stores.mapStore.dispatch(action)
    }
}
