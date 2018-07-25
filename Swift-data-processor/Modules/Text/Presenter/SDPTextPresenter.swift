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
    }
    
    func viewWillAppear(){
        view.prepareForScreen()
        checkActions()
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
        checkActions()
    }
    
    func paste(){
        interactor.paste()
        view.refreshInputActionsState()
        checkActions()
    }
    
    func qr(){
        interactor.subscribeToClipboard()
        router.qr()
    }
    
    func selectAction(_ action: String) {
        weak var wself = self
        
        interactor.requestText { (text) in
            if let text = text {
                wself?.router.perform(action: action, forText: text)
            }
        }

    }
    //MARK: intenal methods
    func checkActions() {
        interactor.requestText { (text) in
            
            if (text?.count ?? 0) > 0{
                actionView?.enable()
            }else{
                actionView?.disable()
            }
        }
    }
    
    // MARK: DPTextInteractorOutput
    func set(actions: [String], titles: [String: String]?){
        let dataSource = SDPSingleSectionTableDataSourceObject<String, String>(elements: actions, values: titles)
        actionView?.set(tableViewDataSource: dataSource)
    }
    
    func textIsReady() {
        router.returnToRootController()
    }
    
    func set(text: String?) {
        view.set(text:text)
    }
    
    // MARK: UITextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        interactor.set(range: textView.selectedRange)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        interactor.set(text: textView.text)
        view.refreshInputActionsState()
        checkActions()
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        interactor.set(range: textView.selectedRange)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        interactor.set(range: nil)
    }

}
