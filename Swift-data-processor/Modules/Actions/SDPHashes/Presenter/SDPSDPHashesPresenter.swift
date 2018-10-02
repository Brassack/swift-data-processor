//
//  SDPHashesSDPSDPHashesPresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit

class SDPHashesPresenter:NSObject, SDPHashesModuleInput, SDPHashesViewOutput, SDPHashesInteractorOutput, UITextFieldDelegate {
    
    weak var view: SDPHashesViewInput!
    var interactor: SDPHashesInteractorInput!
    var router: SDPHashesRouterInput!
    
    var iterationsTextFieldTag: Int = 1
    var saltTextFielTag: Int = 2
    
    private var hashParameters: (iterations: Int, salt: String?) = (iterations: 1, salt: nil)

    private var tableView: UITableView?
    private var tableDataSource: SDPOrdinaryTableViewDataSource?

    // MARK: SDPHashesViewOutput
    func set(iterationsTextFieldTag: Int, saltTextFielTag: Int) {
        
        self.iterationsTextFieldTag = iterationsTextFieldTag
        self.saltTextFielTag = saltTextFielTag
    }
    
    func setupArgon2Parameters() {
        
        interactor.setupAndSubscripeToArgon2Parameters()
        router.argon2Parameters()
    }
    
    func shareHash(atIndexPath indexPath: IndexPath) {
        
        guard let data = tableDataSource?.data else {
            return
        }
        
        guard data.count > indexPath.section else {
            return
        }
        
        let section = data[indexPath.section]
        
        guard section.rows.count > indexPath.row else {
            return
        }
        
        guard !section.rows[indexPath.row].isFailed else {
            return
        }
        
        guard let hash = section.rows[indexPath.row].subtitle else{
            return
        }
        
        
        router.share(hash: hash)
    }
    
    func set(iterations: Int) {
        hashParameters.iterations = iterations
        interactor.requestData(hashParameters)
    }
    
    func generateRandomSalt() {
        let salt = SDPRandom.randomSalt()
        hashParameters.salt = salt
        interactor.requestData(hashParameters)
        view.set(salt: salt)
    }
    
    func scanSaltFromQR() {
        interactor.subscribeForSaltClipboard()
        router.scanQR()
    }
    
    func set(salt: String?) {
        hashParameters.salt = salt
        interactor.requestData(hashParameters)
    }
    
    func viewIsReady(tableView: UITableView) {
        self.tableView = tableView
        view.setupInitialState()
        interactor.requestData(hashParameters)
    }
    
    func viewWillBePresented() {
        view.prepareForScreen()
        interactor.unsubscribeFromSaltClipboard()
        interactor.setupAndSubscripeToArgon2Parameters()
    }
    
    // MARK: SDPHashesInteractorOutput
    
    func setScanned(salt: String?) {
        
        if let vc = view as? UIViewController {
            router.returnTo(view: vc)
        }
        
        hashParameters.salt = salt
        interactor.requestData(hashParameters)
        view.set(salt: salt)
    }
    
    func set(stubData: [SDPTableViewDataSourceSection]?) {
        guard let stubData = stubData else {
            return
        }
        
        guard let tableDataSource = buildTableDataSource(withData: stubData) else {
            return
        }
        
        self.tableDataSource = tableDataSource
        view.setTableDataSource(tableDataSource)
    }
    
    func set(data: [SDPTableViewDataSourceSection]?) {
        
        guard let data = data else {
            return
        }
        
        if let tableDataSource = tableDataSource {
            tableDataSource.data = data
        }else if let tableDataSource = buildTableDataSource(withData: data) {
            self.tableDataSource = tableDataSource
            view.setTableDataSource(tableDataSource)
        }
    }

    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == iterationsTextFieldTag {
            
            if let iterations = Int(textField.text ?? ""), iterations > 0, iterations < 1000 {
                
                hashParameters.iterations = iterations
                interactor.requestData(hashParameters)
            }else{
                
                view.showError(forTextField: textField, fallbackValue: "\(hashParameters.iterations)")
            }
        }else if textField.tag == saltTextFielTag, let salt = textField.text {
            
            hashParameters.salt = salt
            interactor.requestData(hashParameters)
        }
        
        view.refreshSaltActions()
    }
    
    
    // MARK: helper
    private func buildTableDataSource(withData data: [SDPTableViewDataSourceSection]) -> SDPOrdinaryTableViewDataSource? {
        
        guard let tableView = tableView else {
            return nil
        }
        
        let result = SDPOrdinaryTableViewDataSource(tableView: tableView, data: data, cellIdentifier: "Cell", cellExternalConfigurator: nil)
        
        return result
    }
}
