//
//  SDPSettingModuleViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 12/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPSettingModuleViewInput: class {

    func setupInitialState()
    func set(dataSource: SDPMulticlassTableViewDataSource?)
}
