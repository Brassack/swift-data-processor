//
//  SDPTableViewDataSourceObject.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/31/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

public typealias SDPTableViewDataSourceRow = (identifier: String, isFailed: Bool, title: String, subtitle: String?)
public typealias SDPTableViewDataSourceSection = (identifier: String, title: String?, rows: [SDPTableViewDataSourceRow])

class SDPOrdinaryTableViewDataSource: NSObject, UITableViewDataSource {
    
    var data: [SDPTableViewDataSourceSection] {
        didSet{
            tableView.reloadData()
        }
    }
    
    let tableView: UITableView
    let cellIdentifier: String
    let cellExternalConfigurator: SDPTableViewCellExternalConfigurator?
    
    var themeObserver: Any?

    init(tableView: UITableView, data:[SDPTableViewDataSourceSection], cellIdentifier: String, cellExternalConfigurator: SDPTableViewCellExternalConfigurator?) {
        
        self.tableView = tableView
        self.cellIdentifier = cellIdentifier
        self.cellExternalConfigurator = cellExternalConfigurator
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if var cell = cell as? SDPTableViewCellConfigurable {
            
            cell.indexPath = indexPath
            cell.externalConfigurator = cellExternalConfigurator
            cell.configure(object: data[indexPath.section].rows[indexPath.row])
        }
        
        return cell
    }
}
