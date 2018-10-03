//
//  DPTextActionsViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/17/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

protocol SDPTextActionsViewInput: class {
    
    var tableView: UITableView! {get}
    var cellIdentifier: String {get}
    var cellConfigurator: SDPTableViewCellExternalConfigurator? {get}
    
    func set(tableViewDataSource:SDPOrdinaryTableViewDataSource)
    func enable()
    func disable()
}
