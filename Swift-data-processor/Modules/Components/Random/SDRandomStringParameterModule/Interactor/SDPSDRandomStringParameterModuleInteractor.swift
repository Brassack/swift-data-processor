//
//  SDPRandomStringParameterModuleInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPRandomTextParameterModuleInteractor: SDPRandomTextParameterModuleInteractorInput, StoreSubscriber {

    weak var output: SDPRandomTextParameterModuleInteractorOutput!

    var store = SDPReduxStores.shared.randomStore
    
    func requestData() {
        
        store.subscribe(self)
    }
    
    func set(subtype: SDPRandomParametersState.RandomTextSubtype) {
        
        let action = SDPRandomParametersStateSetTextSubtypeAction(type: subtype)
        store.dispatch(action)
    }
    
    func set(count: Int) {
        
        var action: Action?
        
        switch store.state.selectedTextSubtype {
        case .uuid:
            
            break
        case .text:
            
            action = SDPRandomParametersStateSetTextLimitationAction(count: count)
            if action == nil {
                output.invalidDataPassed()
            }
        case .loremIpsum:
            
            action = SDPRandomParametersStateSetLoremIpsumLimitationAction(wordsCount: count)
            if action == nil {
                output.invalidDataPassed()
            }
        }
        
        if let action = action {
            
            store.dispatch(action)
        }
    }
    
    //MARK: StoreSubscriber
    func newState(state: SDPRandomParametersState) {
        
        output.set(state: state)
    }
}
