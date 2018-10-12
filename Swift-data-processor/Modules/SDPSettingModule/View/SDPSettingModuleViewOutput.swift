//
//  SDPSettingModuleViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 12/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPSettingModuleViewOutput {

    func viewIsReady(tableView: Any)
    func select(identifier: String)
}
