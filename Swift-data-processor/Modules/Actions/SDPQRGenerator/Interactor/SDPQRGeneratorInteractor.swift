//
// SDPQRGeneratorInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPQRGeneratorInteractor: SDPQRGeneratorInteractorInput, StoreSubscriber {

    weak var output: SDPQRGeneratorInteractorOutput!
    var stores = SDPReduxStores.shared

    // MARK: SDPQRGeneratorInteractorInput
    func requestClipboardData() {
        stores.mapStore.subscribe(self)
    }
    
    // MARK: StoreSubscriber
    func newState(state: SDPMapState) {
        guard let text = state.map["SDPQRGenerator"] as? String else {
            return
        }
        
        stores.mapStore.unsubscribe(self)
        output.set(text: text)
        let action = SDPMapStateWriteAction(key: "SDPQRGenerator", value: nil)
        stores.mapStore.dispatch(action)
    }
}
