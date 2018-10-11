//
//  SDRandomBinaryParametersModuleSDPRandomBinaryParametersModulePresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import Foundation

class SDPRandomBinaryParametersModulePresenter: SDPRandomBinaryParametersModuleInput, SDPRandomBinaryParametersModuleViewOutput, SDPRandomBinaryParametersModuleInteractorOutput {
    
    weak var view: SDPRandomBinaryParametersModuleViewInput!
    var interactor: SDPRandomBinaryParametersModuleInteractorInput!
    var router: SDPRandomBinaryParametersModuleRouterInput!
    
    var state: SDPRandomParametersState?

    //MARK: SDRandomBinaryParametersModuleViewOutput
    func viewIsReady() {

        view.setupInitialState()
        interactor.requestData()
    }
    
    func set(count: String?) {
        
        guard let count = count else{

            view.showError()
            view.set(count: String(state?.binaryCount ?? 0))
            return
        }
        
        guard let countNumber = Int(count) else {
            
            view.showError()
            view.set(count: String(state?.binaryCount ?? 0))
            return
        }
        
        interactor.set(count: countNumber)
    }
    
    
    //MARK: SDRandomBinaryParametersModuleInteractorOutput
    func incorrectDataPassed() {
        
        view.showError()
        view.set(count: String(state?.binaryCount ?? 0))
    }
    
    func set(state: SDPRandomParametersState?){
        
        self.state = state
        
        view.set(count: String(state?.binaryCount ?? 0))
        
        let placeholder = String(repeating: "0", count: 100)
        guard let binary = state?.binary else {
            
            view.set(hex: placeholder)
            return
        }
        
        let maxIndex = (binary.count < 95 ?  binary.count : 95)
        
        guard let range = Range<Data.Index>(NSMakeRange(0, maxIndex)) else {
            
            view.set(hex: placeholder)
            return
        }

        let piece = binary.subdata(in: range)
        
        var hexString = piece.hexEncodedString()
        
        if binary.count > maxIndex {
            hexString = hexString.appending("...")
        }
        view.set(hex: hexString)
    }
}
