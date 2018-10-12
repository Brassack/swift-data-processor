//
//  SDPSettingModuleViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 12/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPSettingModuleViewController: UITableViewController, SDPSettingModuleViewInput {

    var output: SDPSettingModuleViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady(tableView: tableView)
    }

    // MARK: SDPSettingModuleViewInput
    func setupInitialState() {
    }
    
    func set(dataSource: SDPMulticlassTableViewDataSource?) {
        
        tableView.dataSource = dataSource
    }
    
    //MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        if let identifier = tableView.cellForRow(at: indexPath)?.reuseIdentifier {
            output.select(identifier: identifier)
        }
    }
}
