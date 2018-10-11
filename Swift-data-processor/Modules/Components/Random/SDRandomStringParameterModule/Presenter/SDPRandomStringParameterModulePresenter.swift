//
//  SDPRandomTextParameterModulePresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit

class SDPRandomTextParameterModulePresenter: SDPRandomTextParameterModuleInput, SDPRandomTextParameterModuleViewOutput, SDPRandomTextParameterModuleInteractorOutput {

    weak var view: SDPRandomTextParameterModuleViewInput!
    var interactor: SDPRandomTextParameterModuleInteractorInput!
    var router: SDPRandomTextParameterModuleRouterInput!
    
    var selectedIndex = 0
    var state: SDPRandomParametersState?
    
    var tableView: UITableView?
    var cellConfigurator: ((_ cell: UITableViewCell, _ selectedIndex: Int) -> Void)?
    var tableViewDataSource: SDPOrdinaryTableViewDataSource?
    
    //MARK: SDRandomStringParameterModuleViewOutput
    func viewIsReady(tableView: Any, tableViewCellConfigurator: @escaping (_ cell: Any, _ selectedIndex: Int) -> Void) {
        
        view.setupInitialState()

        if let tableView = tableView as? UITableView {
            
            self.tableView = tableView
            self.cellConfigurator = tableViewCellConfigurator
        }
        
        interactor.requestData()
    }
    
    func select(row: Int) {
        
        guard let subtype = SDPRandomParametersState.RandomTextSubtype(rawValue: row) else {
            return
        }
        
        interactor.set(subtype: subtype)
    }
    
    func set(count: String) {
        
        guard let count = Int(count) else {
            view.showCountError()
            return
        }
        
        interactor.set(count: count)
    }
    
    //MARK: SDRandomStringParameterModuleInteractorOutput
    func invalidDataPassed() {
        
        view.showCountError()
        set(state: state)
    }
    
    func set(state: SDPRandomParametersState?) {
        
        self.state = state
        
        guard let state = state else {
            return
        }
        
        switch state.selectedTextSubtype {
        case .text:
            
            view.set(count: String(state.textCount))
            view.set(textInputDescription: "characters")
            view.set(countInputVisible: true)
            view.set(limitation: "< \(maxRandomTextCount)")
        case .loremIpsum:
            
            view.set(count: String(state.loremIpsumCount))
            view.set(textInputDescription: "words")
            view.set(countInputVisible: true)
            view.set(limitation: "< \(maxRandomLoremIpsumCount)")
        case .uuid:
            
            view.set(countInputVisible: false)
        }
        
        
        var rows = [SDPTableViewDataSourceRow]()
        for subtype in SDPRandomParametersState.RandomTextSubtype.allCases {
            
            var subtitle = state.uuid
            
            switch subtype {
            case .uuid:
                
                subtitle = state.uuid
            case .text:
                
                subtitle = state.text
            case .loremIpsum:
                
                subtitle = state.loremIpsum
            }
            
            let row = SDPTableViewDataSourceRow(identifier: String(subtype.rawValue), isFailed: false, title: subtype.title(), subtitle: subtitle)
            
            rows.append(row)
        }

        let section = SDPTableViewDataSourceSection(identifier: "text", title: nil, rows: rows)
        
        if tableViewDataSource == nil {
            
            guard let tableView = tableView else {
                return
            }
            
            tableViewDataSource = SDPOrdinaryTableViewDataSource(tableView: tableView, data: [section], cellIdentifier: "Cell", cellExternalConfigurator: { [weak self] (cell, row) in
                
                guard let state = self?.state
                else {
                    return
                }
                
                let index =  state.selectedTextSubtype.rawValue
  
                self?.cellConfigurator?(cell, index)
            })
            
            if let tableViewDataSource = tableViewDataSource {

                view.set(tableViewDataSource: tableViewDataSource)
            }
        }else{
            tableViewDataSource?.data = [section]
        }
    }

}
