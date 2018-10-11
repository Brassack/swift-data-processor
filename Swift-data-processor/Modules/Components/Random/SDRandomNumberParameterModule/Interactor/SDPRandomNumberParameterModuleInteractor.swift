//
//  SDPRandomNumberParameterModuleInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPRandomNumberParameterModuleInteractor: SDPRandomNumberParameterModuleInteractorInput, StoreSubscriber {

    weak var output: SDPRandomNumberParameterModuleInteractorOutput!
    var store = SDPReduxStores.shared.randomStore
    
    //MARK: SDRandomNumberParameterModuleInteractorInput
    func requestData() {
        store.subscribe(self)
    }
    
    func update(min: UInt32, max: UInt32) {
        
        if min != store.state.minNumber || max != store.state.maxNumber  {
            
            if let action = SDPRandomParametersStateSetNumberBoundsAction(min: min, max: max) {

                store.dispatch(action)
            }else{
                
                output.invalidDataPassed()
            }
        }
    }
    
    
    //MARK: StoreSubscriber
    func newState(state: SDPRandomParametersState) {
        
        output.set(state: state)
    }
}
