//
//  DPTextActionsViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/17/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPTextActionsViewInput: class {
    
    func set(tableViewDataSource:SDPSingleSectionTableDataSourceObject<String, String>)
    func enable()
    func disable()
}
