//
//  SDPHashesSDPSDPHashesPresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit

class SDPHashesPresenter: SDPHashesModuleInput, SDPHashesViewOutput, SDPHashesInteractorOutput {
    
    weak var view: SDPHashesViewInput!
    var interactor: SDPHashesInteractorInput!
    var router: SDPHashesRouterInput!
    
    private var hashParameters: (iterations: Int, salt: String?) = (iterations: 1, salt: nil)
    
    private var tableView: UITableView?
    private var tableDataSource: SDPOrdinaryTableViewDataSource?

    // MARK: SDPHashesViewOutput
    func copyHash(atIndexPath indexPath: IndexPath) {
        guard let tableDataSource = tableDataSource else {
            return
        }
        
        interactor.copyHash(data: tableDataSource.data, atIndexPath: indexPath)
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
    
    func shareSalt() {
        // TODO: Sharing
    }
    
    func scanSaltFromQR() {
        // TODO: Add QR scan
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
    }
    
    // MARK: SDPHashesInteractorOutput
    func hashCopied(at indexPath: IndexPath) {
        view.hashCopied(at: indexPath)
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
    
    // MARK: helper
    private func buildTableDataSource(withData data: [SDPTableViewDataSourceSection]) -> SDPOrdinaryTableViewDataSource? {
        
        guard let tableView = tableView else {
            return nil
        }
        
        let result = SDPOrdinaryTableViewDataSource(tableView: tableView, data: data, cellIdentifier: "Cell", cellExternalConfigurator: nil)
        
        return result
    }
}
