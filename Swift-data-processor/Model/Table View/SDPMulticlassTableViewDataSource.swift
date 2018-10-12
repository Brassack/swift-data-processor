//
//  SDPMulticlassTableViewDataSource.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/12/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

public typealias SDPTableViewCellIdentifierFunction = ([SDPMulticlassTableViewDataSourceSection], IndexPath) -> String
public typealias SDPTableViewCellExternalConfiguratioFunction = ([SDPMulticlassTableViewDataSourceSection], IndexPath) -> SDPTableViewCellExternalConfigurator?

public typealias SDPMulticlassTableViewDataSourceRow = (identifier: String, data: Any?)
public typealias SDPMulticlassTableViewDataSourceSection = (identifier: String, title: String?, rows: [SDPMulticlassTableViewDataSourceRow])

class SDPMulticlassTableViewDataSource: NSObject, UITableViewDataSource {
    
    var data: [SDPMulticlassTableViewDataSourceSection] {
        didSet{
            tableView.reloadData()
        }
    }
    
    let tableView: UITableView
    let cellIdentifierFunction: SDPTableViewCellIdentifierFunction
    let cellExternalConfiguratorFunction: SDPTableViewCellExternalConfiguratioFunction?
    var themeObserver: Any?
    
    init(tableView: UITableView, data:[SDPMulticlassTableViewDataSourceSection], cellIdentifierFunction: @escaping SDPTableViewCellIdentifierFunction, cellExternalConfiguratorFunction: SDPTableViewCellExternalConfiguratioFunction?) {
        
        self.tableView = tableView
        self.cellIdentifierFunction = cellIdentifierFunction
        self.cellExternalConfiguratorFunction = cellExternalConfiguratorFunction
        
        self.data = data
        
        super.init()
        
        themeObserver = NotificationCenter.default.addObserver(forName: SDPThemeUpdatedNotification, object: nil, queue: nil) { [weak self] (notification) in
            self?.tableView.reloadData()
        }
    }
    
    deinit {
        if let themeObserver = themeObserver {
            NotificationCenter.default.removeObserver(themeObserver)
        }
    }
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = cellIdentifierFunction(data, indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if var cell = cell as? SDPTableViewCellConfigurable {
            
            cell.indexPath = indexPath
            cell.externalConfigurator = cellExternalConfiguratorFunction?(data, indexPath)
            cell.configure(object: data[indexPath.section].rows[indexPath.row])
        }
        
        return cell
    }
}
