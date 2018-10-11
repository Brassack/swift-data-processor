//
//  SDPRandomModuleSDPRandomModuleInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 09/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDRandomModuleInteractor: SDPRandomModuleInteractorInput, StoreSubscriber {

    weak var output: SDPRandomModuleInteractorOutput!
    
    var store = SDPReduxStores.shared.randomStore
    
    //MARK: SDRandomModuleInteractorInput
    func requestData() {
        store.subscribe(self)
    }
    
    func random() {
        
        let action = SDPRandomParametersGenerateSelectedAction()
        store.dispatch(action)
    }
    
    func set(type: SDPRandomParametersState.RandomType) {
        
        let action = SDPRandomParametersStateSetTypeAction(type: type)
        store.dispatch(action)
    }
    
    //MARK: StoreSubscriber
    func newState(state: SDPRandomParametersState) {
        
        output.set(state: state)
    }
}
