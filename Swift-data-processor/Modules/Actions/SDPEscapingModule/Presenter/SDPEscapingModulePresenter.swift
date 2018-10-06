//
// SDPEscapingModulePresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 03/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

class SDPEscapingModulePresenter: SDPEscapingModuleModuleInput, SDPEscapingModuleViewOutput, SDPEscapingModuleInteractorOutput {

    weak var view: SDPEscapingModuleViewInput!
    var interactor: SDPEscapingModuleInteractorInput!
    var router: SDPEscapingModuleRouterInput!
    
    var text: String?
    var parameters = SDPEscapingModuleInteractor.EscapingParameters(type: .url, isEncode: true)

    //MARK: SDPEscapingModuleViewOutput
    func viewIsReady() {

        view.setupInitialState()
        
        let options:[SDPPickerSingleOptionInput.Value] = [SDPPickerSingleOptionInput.Value(valueDescription: "URL", value: SDPEscapingModuleInteractor.EscapingType.url),
                                                          SDPPickerSingleOptionInput.Value(valueDescription: "HTML", value: SDPEscapingModuleInteractor.EscapingType.html)
        ]
        
        view.setup(pickerOptions: options, defaultValue: options.first)
        interactor.set(parameters: parameters)
        interactor.requestData()
    }
    
    func viewWillBePresented() {
        
        view.prepareForScreen()
    }
    
    func set(isEncoding: Bool) {
        
        parameters.isEncode = isEncoding
        interactor.set(parameters: parameters)
    }
    
    func set(type: SDPEscapingModuleInteractor.EscapingType) {
        
        parameters.type = type
        interactor.set(parameters: parameters)
    }
    
    func share() {
        
        guard let text = text else {
            return
        }
        router.share(text: text)
    }
    
    //MARK: SDPEscapingModuleInteractorOutput
    func set(text: String?) {
        
        self.text = text
        view.show(text: text)
    }
}
