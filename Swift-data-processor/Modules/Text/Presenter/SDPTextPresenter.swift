//
//  TexSDPTextPresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import ReSwift

class SDPTextPresenter:NSObject, SDPTextModuleInput, SDPTextViewOutput, SDPTextInteractorOutput {

    weak var view: SDPTextViewInput!
    weak var actionView: SDPTextActionsViewInput?
    var interactor: SDPTextInteractorInput!
    var router: SDPTextRouterInput!
    
    // MARK: DPTextViewOutput
    func viewIsReady() {
        view.setupInitialState()
        router.registerNavigationController(forView: view)
    }
    
    func viewWillBePresented(){
        interactor.unsubscribeFromClipboard()
        view.prepareForScreen()
        view.refreshInputActionsState()
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "actions", let vc = segue.destination as? UITableViewController {
            let configurator = SDPTextModuleConfigurator()
            configurator.configureActions(actionsInput: vc, withOutput: self)
            
            actionView = vc as? SDPTextActionsViewInput
            interactor.requestActions()
        }
    }
    
    func copy(){
        interactor.copy()
        view.refreshInputActionsState()
    }
    
    func paste(){
        interactor.paste()
        view.refreshInputActionsState()
    }
    
    func qr(){
        interactor.subscribeToClipboard()
        router.qr()
    }
    
    func selectAction(_ action: String) {
        
        if action == "SDPQRGenerator" {
            
            interactor.requestValidationForQRGenerator()
        }else{
            interactor.addTextToclipboard(action: action)
            router.showScreen(forAction: action)
        }
    }
    
    //MARK: intenal methods
    func checkActions(text:String?) {
        if (text?.count ?? 0) > 0 {
            actionView?.enable()
        }else{
            actionView?.disable()
        }
    }
    
    // MARK: DPTextInteractorOutput
    
    func textForQR(valid isValid: Bool) {
        
        if isValid {
            let action = "SDPQRGenerator"
            interactor.addTextToclipboard(action: action)
            router.showScreen(forAction: action)
        }else{
            
            router.showTooLongTextFoQRError()
        }
    }
    
    func set(actions: [String], titles: [String: String]?){
        let dataSource = SDPSingleSectionTableDataSourceObject<String, String>(elements: actions, values: titles)
        actionView?.set(tableViewDataSource: dataSource)
    }
    
    func textAddedToClipboard() {
        router.returnToRootController()
    }
    
    func set(text: String?) {
        view.set(text:text)
        checkActions(text: text)
    }
    
    // MARK: UITextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        interactor.set(range: textView.selectedRange)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        interactor.set(text: textView.text)
        checkActions(text: textView.text)
        view.refreshInputActionsState()
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        interactor.set(range: textView.selectedRange)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        interactor.set(range: nil)
    }

}
