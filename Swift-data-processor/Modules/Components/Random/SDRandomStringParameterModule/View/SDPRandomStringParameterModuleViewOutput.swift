//
//  SDPRandomStringParameterModuleViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPRandomTextParameterModuleViewOutput {

    func viewIsReady(tableView: Any, tableViewCellConfigurator: @escaping (_ cell: Any, _ selectedIndex: Int) -> Void)
    func select(row: Int)
    func set(count: String)
}
