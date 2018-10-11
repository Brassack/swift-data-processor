//
//  SDPRandomBinaryParametersModuleSDPRandomBinaryParametersModuleInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPRandomBinaryParametersModuleInteractor: SDPRandomBinaryParametersModuleInteractorInput, StoreSubscriber {

    weak var output: SDPRandomBinaryParametersModuleInteractorOutput!
    
    var store = SDPReduxStores.shared.randomStore

    //MARK: SDRandomBinaryParametersModuleInteractorInput
    
    func requestData() {
        store.subscribe(self)
    }

    func set(count: Int) {
        
        guard let action = SDPRandomParametersStateSetBinaryLimitationAction(count: count) else{
            
            output.incorrectDataPassed()
            return
        }
        
        store.dispatch(action)
    }
    
    //MARK: StoreSubscriber
    func newState(state: SDPRandomParametersState) {
        
        output.set(state: state)
    }
    

}
