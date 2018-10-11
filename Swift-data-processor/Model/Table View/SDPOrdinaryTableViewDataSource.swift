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
    
//    private var oldData: [SDPTableViewDataSourceSection]?
    var data: [SDPTableViewDataSourceSection] {
//        willSet{
//            oldData = data
//        }
        didSet{
            tableView.reloadData()

//            if let oldData = oldData {
//
//                tableView.beginUpdates()
//
//                for i in 0..<oldData.count {
//                    let indexSet = IndexSet(integer: i)
//                    let section = oldData[i]
//
//                    if data.count <= i {
//                        tableView.deleteSections(indexSet, with: .fade)
//                        break
//                    }
//
//                    let oldSection = data[i]
//
//                    if oldSection.identifier == section.identifier {
//                        tableView.reloadSections(indexSet, with: .fade)
//                        break
//                    }
//
//                    tableView.deleteSections(indexSet, with: .fade)
//                    tableView.insertSections(indexSet, with: .fade)
//                }
//
//                tableView.endUpdates()
//
//
//            }else{
//                tableView.reloadData()
//            }
//
//            oldData = nil
        }
    }
    
    let tableView: UITableView
    let cellIdentifier: String
    let cellExternalConfigurator: SDPTableViewCellExternalConfigurator?
    
    init(tableView: UITableView, data:[SDPTableViewDataSourceSection], cellIdentifier: String, cellExternalConfigurator: SDPTableViewCellExternalConfigurator?) {
        
        self.tableView = tableView
        self.cellIdentifier = cellIdentifier
        self.cellExternalConfigurator = cellExternalConfigurator
        
        self.data = data
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
