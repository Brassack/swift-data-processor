//
//  SDPRandomNumberParameterModulePresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

class SDPRandomNumberParameterModulePresenter: SDPRandomNumberParameterModuleModuleInput, SDPRandomNumberParameterModuleViewOutput, SDPRandomNumberParameterModuleInteractorOutput {

    weak var view: SDPRandomNumberParameterModuleViewInput!
    var interactor: SDPRandomNumberParameterModuleInteractorInput!
    var router: SDPRandomNumberParameterModuleRouterInput!
    
    var state: SDPRandomParametersState?

    func viewIsReady() {
        view.setupInitialState()
        interactor.requestData()
    }
    
    //MARK: SDRandomNumberParameterModuleInteractorOutput
    func invalidDataPassed() {
        
        view.showMaxError()
        view.showMinError()
    }
    
    func set(state: SDPRandomParametersState?) {
        
        self.state = state
        
        guard let state = state else {
            return
        }
        
        view.set(max: String(state.maxNumber))
        view.set(min: String(state.minNumber))
        view.set(result: String(state.number))
    }
    
    //MARK: SDRandomNumberParameterModuleViewOutput
    func set(max: String) {
        
        guard let maxNumber = UInt32(max),
         maxNumber > state?.minNumber ?? 0
        else {
            view.showMaxError()
            view.set(max: String(state?.maxNumber ?? 1))
            return
        }
        
        interactor.update(min: state?.minNumber ?? 0, max: maxNumber)
    }
    
    func set(min: String) {
        
        guard let minNumber = UInt32(min),
            minNumber < state?.maxNumber ?? 0
        else {
            view.showMinError()
            view.set(min: String(state?.minNumber ?? 0))
            return
        }
        
        interactor.update(min: minNumber, max: state?.maxNumber ?? 1)
    }
}
