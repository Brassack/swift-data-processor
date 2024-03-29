//
//  SDPRawKeyModuleSDPRawKeyModulePresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRawKeyModulePresenter: SDPRawKeyModuleModuleInput, SDPRawKeyModuleViewOutput, SDPRawKeyModuleInteractorOutput {

    weak var view: SDPRawKeyModuleViewInput!
    var interactor: SDPRawKeyModuleInteractorInput!
    var router: SDPRawKeyModuleRouterInput!
    
    var parameters: SDPEncryptionParameters?
    var themeObserver: Any?

    //MARK: SDPRawKeyModuleViewOutput
    func viewIsReady() {
        interactor.requestData()
        view.setupInitialState()
        themeObserver = NotificationCenter.default.addObserver(forName: SDPThemeUpdatedNotification, object: nil, queue: nil) { [weak self] (notification) in
            self?.view.updateTheme(theme: notification.object as? SDPApplicationTheme)
        }
        view.updateTheme(theme: (UIApplication.shared.delegate as? AppDelegate)?.configurator.theme)
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
    
    func set(key: String?) {
        
        if let key = key, key.count > 0 {
            
            if key.isHexEncodedData {
                
                let data = key.hexDecodedData()
                interactor.set(key: data)
            }else{
                
                let keyString = parameters?.rawKey?.hexEncodedString()
                view.set(key: keyString)
                view.set(status:"\(keyString?.count ?? 0) of \((parameters?.keySize ?? 0) * 2)")
                view.showInvalidKeyError()
            }
        }else{
            
            interactor.set(key: nil)
        }
    }
    
    func setTextInProgress(_ text: String?) {
    
        view.set(status:"\(text?.count ?? 0) of \((parameters?.keySize ?? 0) * 2)")
    }
    
    //MARK: SDPRawKeyModuleInteractorOutput
    func set(parameters: SDPEncryptionParameters) {
        
        self.parameters = parameters
        
        let keyString = parameters.rawKey?.hexEncodedString()
        view.set(key: keyString)
        view.set(status:"\(keyString?.count ?? 0) of \(parameters.keySize * 2)")
    }
}
