//
//  SDPRawKeyModuleSDPSDPRawKeyModulePresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRawKeyModulePresenter:NSObject, SDPRawKeyModuleModuleInput, SDPRawKeyModuleViewOutput, SDPRawKeyModuleInteractorOutput {

    weak var view: SDPRawKeyModuleViewInput!
    var interactor: SDPRawKeyModuleInteractorInput!
    var router: SDPRawKeyModuleRouterInput!
    
    var parameters: SDPEncryptionParameters?

    //MARK: SDPRawKeyModuleViewOutput
    func viewIsReady() {
        interactor.requestData()
        view.setupInitialState()
    }

    func generateRandomKey() {
        
        guard let parameters = parameters else {
            return
        }
        
        do{
            
            let key = try SDPEncryptionKeyGenerator.makeRandomKey(size: parameters.keySize)
            interactor.set(key: key)
        }catch{
            
            interactor.set(key: nil)
        }
    }
    
    func share() {
        
        guard let keyString = parameters?.rawKey?.hexEncodedString() else {
            return
        }
        
        router.share(text: keyString)
    }
    
    func scanFromQR() {
        
        router.scanQR()
        interactor.subscribeForQRClipboard()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let data = textField.text?.hexDecodedData()
        interactor.set(key: data)
    }
    
    //MARK: SDPRawKeyModuleInteractorOutput
    func set(parameters: SDPEncryptionParameters) {
        
        self.parameters = parameters
        view.set(key: parameters.rawKey?.hexEncodedString())
    }
    
    func setQRFinished() {
        router.pop()
    }
}
