//
//  SDPEncryptionSDPSDPEncryptionPresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit
import CommonCrypto


class SDPEncryptionPresenter: SDPEncryptionModuleInput, SDPEncryptionViewOutput, SDPEncryptionInteractorOutput  {

    enum SDPEncryptionKeyType {
        case passwordBased
        case raw
    }
    
    enum SDPEncryptionState: Equatable {
        case notProcessing
        case processing(Data)
        case invalidated
    }
    
    weak var view: SDPEncryptionViewInput!
    var interactor: SDPEncryptionInteractorInput!
    var router: SDPEncryptionRouterInput!
    
    var pageViewController: UIPageViewController?
    
    var passwordBasedKeyViewFactory: (() -> UIViewController?)?
    var rawKeyViewFactory: (() -> UIViewController?)?
    
    var text: String?
    var data: Data?
    var isEncoding: Bool = true
    
    var keyType = SDPEncryptionKeyType.passwordBased {
        didSet{
            calculateIfPossible()
        }
    }
    
    var method: SDPCipherType = .aes {
        didSet{
            calculateIfPossible()
        }
    }
    
    var keySize = Int(kCCKeySizeAES128){
        didSet{
            calculateIfPossible()
        }
    }
    
    var key: Data? {
        get {
            switch keyType {
            case .passwordBased:
                return parameters?.computedRawKey
            case .raw:
                return parameters?.rawKey
            }
        }
    }
    var state: SDPEncryptionState = .notProcessing
    var result: Data?{
        didSet{
            if result != nil {
                view.set(state: .ready)
            }
        }
    }
    
    var parameters: SDPEncryptionParameters?

    func calculateIfPossible() {
        //TODO: Handle files
        guard let key = key else {
            
            view.set(state: .message("Please enter the key"))
            return
        }
        
        let method = self.method
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
        
        let isEncoding = self.isEncoding

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
    
    func set(isEncoding: Bool) {
        self.isEncoding = isEncoding
        view.set(title: isEncoding ? "Encryption" : "Decryption")
    }
    
    func set(parameters: SDPEncryptionParameters?) {
        self.parameters = parameters
        calculateIfPossible()
    }
    
    //MARK: SDPEncryptionViewOutput
    func viewIsReady() {
        
        view.setupInitialState()
        interactor.setupParameters(withKeySize: keySize)
        interactor.requestClipboardData()
        
        let sizes = keySizeValue(forMethod: method)
        view.set(keySizesPickerValues: sizes, defaultValue: SDPPickerSingleOptionInput.Value(valueDescription: "\(method.defaultKeySize()*16)bit", value: method.defaultKeySize()))
        var values = [SDPPickerSingleOptionInput.Value]()
        
        let types: [SDPCipherType] = [.aes, .blowfish]
        for method in types {
            
            values.append(SDPPickerSingleOptionInput.Value(valueDescription: "\(method.description())", value: method))
        }
        
        view.set(methodPickerValues: values, defaultValue: values.first)

    }
    
    func shareResult() {
        
        guard let result = result else {
            return
        }
        
        router.share(data: result)
    }
    
    func viewWillBePresented() {
        view.prepareForScreen()
    }
    
    func pageViewIsready(_ pageViewController: UIPageViewController) {
        
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
        
        keyType = SDPEncryptionKeyType.passwordBased
        router.set(page: page, forPageController: pageViewController, direction: .reverse)

    }
    
    func didSelectRawBased() {
        
        guard let page = rawKeyViewFactory?(), let pageViewController = pageViewController else {
            return
        }
        keyType = SDPEncryptionKeyType.raw
        router.set(page: page, forPageController: pageViewController, direction: .forward)
    }
    
    func set(method: SDPCipherType) {
        
        self.method = method
        view.set(keySizesPickerValues: keySizeValue(forMethod: method), defaultValue: SDPPickerSingleOptionInput.Value(valueDescription: "\(method.defaultKeySize()*16)bit", value: method.defaultKeySize()))
    }
    
    func set(keySize: Int) {
        
        self.keySize = keySize
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
