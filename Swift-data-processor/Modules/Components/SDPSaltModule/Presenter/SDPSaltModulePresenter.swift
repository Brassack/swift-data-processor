//
// SDPSaltModulePresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit

class SDPSaltModulePresenter:NSObject, SDPSaltModuleModuleInput, SDPSaltModuleViewOutput, SDPSaltModuleInteractorOutput {

    weak var view: SDPSaltModuleViewInput!
    var interactor: SDPSaltModuleInteractorInput!
    var router: SDPSaltModuleRouterInput!
    var salt: String?

    func viewIsReady() {
        
        view.setupInitialState()
        interactor.requestData()
    }
    
    func set(salt: String?) {
        guard self.salt != salt else {
            return
        }
        
        self.salt = salt
        view.set(salt: salt)
    }
    
    //MARK: SDPSaltModuleViewOutput
    func generateRandomSalt() {
        
        let salt = SDPRandom.randomSalt()
        interactor.set(salt: salt)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        interactor.set(salt: textField.text)
    }
}
