//
//  SDPEncryptionParametersModuleSDPPEncryptionParametersModulePresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 08/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

class SDPEncryptionParametersModulePresenter: SDPEncryptionParametersModuleModuleInput, SDPEncryptionParametersModuleViewOutput, SDPEncryptionParametersModuleInteractorOutput {

    enum SDPEncryptionKeyType {
        case passwordBased
        case raw
    }
    
    enum Direction {
        
        case forward
        case reverse
    }
    
    weak var view: SDPEncryptionParametersModuleViewInput!
    var interactor: SDPEncryptionParametersModuleInteractorInput!
    var router: SDPEncryptionParametersModuleRouterInput!

    var pageViewController: Any?
    
    var passwordBasedKeyViewFactory: (() -> Any?)?
    var rawKeyViewFactory: (() -> Any?)?
    
    var parameters: SDPEncryptionParameters?
    
    //MARK: SDPEncryptionParametersModuleViewOutput
    func viewIsReady() {
        
        interactor.requestParameters()
    }
    
    func pageViewIsready(_ pageViewController: Any) {
        
        self.pageViewController = pageViewController
        
        guard let page = passwordBasedKeyViewFactory?() else {
            return
        }
        
        router.set(page: page, forPageController: pageViewController, direction: .forward)
    }

    func didSelectPasswordBased() {
        
        guard let page = passwordBasedKeyViewFactory?(), let pageViewController = pageViewController else {
            return
        }
        
        parameters?.keyType = SDPEncryptionKeyType.passwordBased
        interactor.update(parameters: parameters)
        
        router.set(page: page, forPageController: pageViewController, direction: .reverse)
    }
    
    func didSelectRawBased() {
        
        guard let page = rawKeyViewFactory?(), let pageViewController = pageViewController else {
            return
        }
    
        parameters?.keyType = SDPEncryptionKeyType.raw
        interactor.update(parameters: parameters)
        
        router.set(page: page, forPageController: pageViewController, direction: .forward)
    }
    
    func set(method: SDPCipherType) {
        
        parameters?.method = method
        parameters?.keySize = method.defaultKeySize()
        interactor.update(parameters: parameters)
        
    }
    
    func set(keySize: Int) {
        
        parameters?.keySize = keySize
        interactor.update(parameters: parameters)
    }
    
    func set(parameters: SDPEncryptionParameters?) {
        
        self.parameters = parameters
        
        guard  let parameters = parameters else {
            return
        }

        var methods = [SDPPickerSingleOptionInput.Value]()
        
        let types: [SDPCipherType] = [.aes, .blowfish]
        for method in types {
            methods.append(SDPPickerSingleOptionInput.Value(valueDescription: "\(method.description())", value: method))
        }
        view.set(methodPickerValues: methods, defaultValue: SDPPickerSingleOptionInput.Value(valueDescription: "\(parameters.method.description())", value: parameters.method))
        
        let sizes = parameters.method.keySizeList()
        
        var keys = [SDPPickerSingleOptionInput.Value]()
        
        for size in sizes {
            keys.append(SDPPickerSingleOptionInput.Value(valueDescription: "\(size*16)bit", value: size))
        }
        
        view.set(keySizesPickerValues: keys, defaultValue: SDPPickerSingleOptionInput.Value(valueDescription: "\(parameters.keySize*16)bit", value: parameters.keySize))
    }
    
    //MARK: Helper
    func keySizeValue(forMethod method: SDPCipherType) -> [SDPPickerSingleOptionInput.Value] {
        
        var values = [SDPPickerSingleOptionInput.Value]()
        
        for size in method.keySizeList() {
            
            values.append(SDPPickerSingleOptionInput.Value(valueDescription: "\(size*16)bit", value: size))
        }
        
        return values
    }
}
