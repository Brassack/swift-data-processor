//
//  SDPArgon2ParametersPopupSDPSDPArgon2ParametersPopupPresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 27/08/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit
import CatCrypto

class SDPArgon2ParametersPopupPresenter: NSObject, SDPArgon2ParametersPopupModuleInput, SDPArgon2ParametersPopupViewOutput, SDPArgon2ParametersPopupInteractorOutput, UITextFieldDelegate {

    weak var view: SDPArgon2ParametersPopupViewInput!
    var interactor: SDPArgon2ParametersPopupInteractorInput!
    var router: SDPArgon2ParametersPopupRouterInput!
    var parameters: SDPArgon2Parameters = (hashLength: argon2DefaultHashLength, memory:argon2DefaultMemory, parallelism: argon2DefaultParallelism)
    var tags = (hashLength: 1, memory:2, parallelism: 3)
    
    // MARK: SDPArgon2ParametersPopupInteractorOutput
    func setup(withParameters parameters: SDPArgon2Parameters?) {
        
        self.parameters = parameters ?? self.parameters
        view.setup(parameters: self.parameters)
    }
    
    // MARK: SDPArgon2ParametersPopupViewOutput
    func viewIsReady(hashLenghtTag: Int, memoryTag: Int, parallelismTag: Int) {
        view.setupInitialState()
        tags = (hashLength: hashLenghtTag, memory: memoryTag, parallelism: parallelismTag)
        interactor.setup()
    }
    
    func saveParameters() {
        
        interactor.parametersReady(parameters)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {

        let check: (_ min: Int, _ max: Int, _ fallbackValue: Int) -> Int?  = { [weak self] ( min: Int, max: Int, fallbackValue: Int) in
            
            let fallback = {
                
                self?.view.showError(forTextField: textField, fallbackValue: "\(fallbackValue)")
            }
            
            if let result = Int(textField.text ?? "") {
                
                if result < min {
                    
                    fallback()
                }else if result > max {
                    
                    fallback()
                }else{
                    
                    return result
                }
            }else{
                
                fallback()
            }
            
            return nil
        }
        
        switch textField.tag {
        
        case tags.hashLength:
            
            if let hashLenght = check(argon2MinHashLength, argon2MaxHashLength, parameters.hashLength) {
                parameters.hashLength = hashLenght
            }
        case tags.memory:
            
            if let memory = check(argon2MinMemory, argon2MaxMemory, parameters.memory) {
                
                parameters.memory = memory
            }
        case tags.parallelism:
            
            if let parallelism = check(argon2MinParallelism, argon2MaxParallelism, parameters.parallelism) {
                
                parameters.parallelism = parallelism
            }
        default:
            break
        }
    }
}
