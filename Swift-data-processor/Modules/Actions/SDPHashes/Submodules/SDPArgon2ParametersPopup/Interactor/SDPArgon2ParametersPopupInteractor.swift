//
//  SDPArgon2ParametersPopupSDPArgon2ParametersPopupInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 27/08/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import ReSwift

class SDPArgon2ParametersPopupInteractor: SDPArgon2ParametersPopupInteractorInput, StoreSubscriber {

    weak var output: SDPArgon2ParametersPopupInteractorOutput!
    var stores = SDPReduxStores.shared
    var parametersWriteKey: AnyHashable?
    
    func setup() {
        stores.mapStore.subscribe(self)
    }
    
    func newState(state: SDPMapState) {
        
        guard let key = state.map[SDPArgon2ParametersPopupVariables.argon2ParametersPopupWriteKey] as? AnyHashable,
            let parameters = state.map["SDPArgon2ParametersPopup"] as? SDPArgon2Parameters else {
            return
        }
        
        parametersWriteKey = key
        output.setup(withParameters: parameters)
        
        stores.mapStore.unsubscribe(self)
        let keysToRemove = [SDPArgon2ParametersPopupVariables.argon2ParametersPopupWriteKey, "SDPArgon2ParametersPopup"]
        
        for key in keysToRemove {
            
            let action = SDPMapStateWriteAction(key: key, value: nil)
            stores.mapStore.dispatch(action)
        }
    }

    func parametersReady(_ parameters: SDPArgon2Parameters) {
        
        guard let parametersWriteKey = parametersWriteKey else {
            return
        }
        
        let action = SDPMapStateWriteAction(key: parametersWriteKey, value: parameters)
        stores.mapStore.dispatch(action)
    }
}
