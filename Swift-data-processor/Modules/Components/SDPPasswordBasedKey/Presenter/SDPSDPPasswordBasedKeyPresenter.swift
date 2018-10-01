//
//  SDPPasswordBasedKeySDPSDPPasswordBasedKeyPresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPPasswordBasedKeyPresenter:NSObject, SDPPasswordBasedKeyModuleInput, SDPPasswordBasedKeyViewOutput, SDPPasswordBasedKeyInteractorOutput {
    
    weak var view: SDPPasswordBasedKeyViewInput!
    var interactor: SDPPasswordBasedKeyInteractorInput!
    var router: SDPPasswordBasedKeyRouterInput!
    
    var parameters: SDPEncryptionParameters?

    //MARK: SDPPasswordBasedKeyViewOutput
    func viewIsReady(saltContainerView: UIView) {
        
        view.setupInitialState()
        
        if let vc = view as? UIViewController {
            router.showSaltView(intoView: saltContainerView, forParent: vc)
        }
        
        interactor.requestData()
    }
    
    func shareRawKey(){
        
        if let key = parameters?.computedRawKey?.hexEncodedString() {
            router.share(text: key)
        }
    }
    
    //MARK:SDPPasswordBasedKeyInteractorOutput
    func setQRFinished() {
        
        router.pop()
    }
    
    func set(parameters: SDPEncryptionParameters) {
        
        self.parameters = parameters
        view.set(password: parameters.password)
        view.set(rawKeyString: parameters.computedRawKey?.hexEncodedString())
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        var parameters = self.parameters
        parameters?.password = textField.text
        interactor.set(parameters: parameters)
    }
    
    func scanSaltFromQR() {
        
        interactor.subscribeForSaltClipboard()
        router.scanQR()
    }

}
