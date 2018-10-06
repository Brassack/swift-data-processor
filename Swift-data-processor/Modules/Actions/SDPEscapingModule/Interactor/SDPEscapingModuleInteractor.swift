//
// SDPEscapingModuleInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 03/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPEscapingModuleInteractor: SDPEscapingModuleInteractorInput, StoreSubscriber {

    enum EscapingType {
        case url
        case html
    }
    typealias EscapingParameters = (type: EscapingType, isEncode: Bool)
    
    
    weak var output: SDPEscapingModuleInteractorOutput!
    
    var stores = SDPReduxStores.shared
    var parameters = EscapingParameters(type: .url, isEncode: true)
    var text: String?
    
    //MARK: SDPEscapingModuleInteractorInput
    func requestData() {
        
        stores.mapStore.subscribe(self)
    }
    
    func set(parameters: SDPEscapingModuleInteractor.EscapingParameters) {
        
        self.parameters = parameters
        calculate()
    }
    
    //MARK: StoreSubscriber
    func newState(state: SDPMapState) {
        
        if let text = state.map["SDPEscaping"] as? String {
            
            self.text = text
            calculate()
            stores.mapStore.unsubscribe(self)
            let action = SDPMapStateWriteAction(key: "SDPEscaping", value: nil)
            stores.mapStore.dispatch(action)
        }
    }
    
    //MARK: Internal
    private func calculate() {
        
        switch parameters.type {
        case .url:

            let result = parameters.isEncode ?
                    text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    : text?.removingPercentEncoding
            output.set(text: result)
            break
        case .html:
            
            let result = parameters.isEncode ?
                text?.htmlEscape()
                : text?.htmlUnescape()
            output.set(text: result)
            break
        }
    }

}
