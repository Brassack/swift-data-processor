//
// SDPEncryptionPresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import Foundation
import CommonCrypto

class SDPEncryptionPresenter: SDPEncryptionModuleInput, SDPEncryptionViewOutput, SDPEncryptionInteractorOutput  {

    enum SDPEncryptionState: Equatable {
        case notProcessing
        case processing(Data)
        case invalidated
    }
    
    weak var view: SDPEncryptionViewInput!
    var interactor: SDPEncryptionInteractorInput!
    var router: SDPEncryptionRouterInput!
    
    var text: String?
    var data: Data?
    
    var key: Data? {
        get {
            guard let parameters = parameters else {
                return nil
            }
            
            switch parameters.keyType {
            case .passwordBased:
                return parameters.computedRawKey
            case .raw:
                return parameters.rawKey
            }
        }
    }
    
    var state: SDPEncryptionState = .notProcessing
    var isConvertToText = false
    var result: Data?{
        didSet{
            if result != nil {
                view.set(state: .ready)
            }
        }
    }
    
    var parameters: SDPEncryptionParameters? {
        didSet{
            calculateIfPossible()
        }
    }

    func calculateIfPossible() {
        //TODO: Handle files
        guard let key = key else {
            
            view.set(state: .message("Please enter the key"))
            return
        }
        guard let parameters = parameters else {
            
            view.set(state: .message("Somethig went wrong"))
            return
        }
        guard key.count == parameters.keySize else {
            
            view.set(state: .message("Invalid key size"))
            return
        }
        
        let method = parameters.method
        
        guard let data = self.text?.data(using: .utf8) ?? self.data else {
            //TODO: Handle error
            return
        }
        
        switch state {
        case .notProcessing:
            break
        case .invalidated:
            return
        case .processing(let processingKey):
            if processingKey != key {
                state = .invalidated
            }
            return
        }
        
        let isEncoding = parameters.isEncoding

        state = .processing(key)
        view.set(state: .processing)
        
        DispatchQueue.global(qos: .default).async { [weak self] in
            do{
                let cipher = try SDPCipherFactory.factory(type: method).produce(key: key)

                let result = isEncoding ? try cipher.encrypt(data) : try cipher.decrypt(data)

                DispatchQueue.main.async {

                    if self?.state == .invalidated {
                        
                        self?.state = .notProcessing
                        self?.calculateIfPossible()
                    }else{
                        
                        self?.state = .notProcessing
                        self?.result = result
                    }
                }
            }catch{
                
                print("Error \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.state = .notProcessing
                    self?.result = nil
                    self?.view.set(state: .message(error.localizedDescription))
                }
            }
        }

    }

    //MARK: SDPEncryptionInteractorOutput
    func set(text: String) {
        self.text = text
    }
    
    func set(data: Data)  {
        self.data = data
    }
    
    func set(parameters: SDPEncryptionParameters?) {
        
        view.set(title: (parameters?.isEncoding ?? false) ? "Encryption" : "Decryption")
        view.setConvertOption(visible: !(parameters?.isEncoding ?? false), isConvert: isConvertToText)
        self.parameters = parameters
    }
    
    //MARK: SDPEncryptionViewOutput
    func set(isConvertToText: Bool) {
        
        self.isConvertToText = isConvertToText
    }
    
    func viewIsReady(parametersContainer: Any) {
        
        interactor.requestData()
        view.setupInitialState()
        router.addParametersView(toView: parametersContainer, controller: view)
    }
    
    func shareResult() {
        
        guard let result = result else {
            return
        }
        
        if isConvertToText {
            
            if let text = String(data: result, encoding: .utf8) {
                router.share(text: text)
            }else{
                router.show(errorMessage: "It is not valid unicode string!", in: view)
            }
        }else{
            
            router.share(data: result)
        }
    }
    
    func viewWillBePresented() {
        view.prepareForScreen()
    }
}
