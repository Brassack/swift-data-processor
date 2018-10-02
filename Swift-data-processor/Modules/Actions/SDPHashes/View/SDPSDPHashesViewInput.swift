//
//  SDPHashesSDPSDPHashesViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit
protocol SDPHashesViewInput: class {
    
    func showError(forTextField textField: Any?, fallbackValue: String?)
    func setupInitialState()
    func setTableDataSource(_ dataSource: UITableViewDataSource)
    func prepareForScreen()
    func set(salt: String?)
    func refreshSaltActions()
}
