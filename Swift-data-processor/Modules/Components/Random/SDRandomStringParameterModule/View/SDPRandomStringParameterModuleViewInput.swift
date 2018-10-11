//
//  SDPRandomStringParameterModuleViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPRandomTextParameterModuleViewInput: class {

    func setupInitialState()
    func set(tableViewDataSource: SDPOrdinaryTableViewDataSource)
    func set(textInputDescription: String?)
    func set(count: String)
    func set(countInputVisible: Bool)
    func set(limitation: String)
    func showCountError()
}
