//
// SDPTextPresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import ReSwift

class SDPTextModulePresenter:NSObject, SDPTextModuleInput, SDPTextModuleViewOutput, SDPTextModuleInteractorOutput {
    
    weak var view: SDPTextModuleViewInput!
    weak var actionView: SDPTextModuleActionsViewInput?
    var interactor: SDPTextModuleInteractorInput!
    var router: SDPTextModuleRouterInput!
    
    var themeObserver: Any?
    
    var actions: [SDPTextModuleInteractor.SDPTextActionItem]?
    
    //MARK: lifecycle
    deinit {
        if let themeObserver = themeObserver {
            NotificationCenter.default.removeObserver(themeObserver)
        }
    }
    
    // MARK: DPTextViewOutput
    func viewIsReady() {
        view.setupInitialState()
        router.registerNavigationController(forView: view)
        
        themeObserver = NotificationCenter.default.addObserver(forName: SDPThemeUpdatedNotification, object: nil, queue: nil) { [weak self] (notification) in
            self?.view.updateTheme(theme: notification.object as? SDPApplicationTheme)
        }
        view.updateTheme(theme: (UIApplication.shared.delegate as? AppDelegate)?.configurator.theme)
        router.showWalkthroughIfNeeded()
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
            
            actionView = vc as? SDPTextModuleActionsViewInput
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
    
    func selectAction(index: Int) {
        guard let action = actions?[index] else {
            return
        }
        
        let perform = { [weak self] () in
            
            guard self != nil else {
                return
            }
            
            guard action.preparation() else {
                self?.router.show(errorMessage: "Something went wrong")
                return
            }
            
            self?.router.showScreen(forAction: action.idx)
        }
        
        if let validation = action.validate?(){
            if validation.isValid {
            
                perform()
            }else{
                
                if let message = validation.invalidReason {
                    router.show(errorMessage: message)
                }else{
                    router.show(errorMessage: "Something went wrong")
                }
            }
        }else{
            
            perform()
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
    func set(actions: [SDPTextModuleInteractor.SDPTextActionItem]) {
        
        self.actions = actions
        
        guard let tableView = actionView?.tableView, let cellIdentifier = actionView?.cellIdentifier else {
            return
        }
        
        var rows = [SDPTableViewDataSourceRow]()
        
        for action in actions {
            
            let row = SDPTableViewDataSourceRow(identifier: action.idx, isFailed: false, title: action.title, subtitle: nil)
            rows.append(row)
        }
        
        let section: SDPTableViewDataSourceSection = SDPTableViewDataSourceSection(identifier:"Options", title: nil, rows: rows)
        
        let dataSource = SDPOrdinaryTableViewDataSource(tableView: tableView, data: [section], cellIdentifier: cellIdentifier, cellExternalConfigurator: actionView?.cellConfigurator)
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
