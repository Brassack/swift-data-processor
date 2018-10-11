//
//  SDPRandomModuleViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 09/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPRandomModuleViewInput: class {

    func setupInitialState()
    func set(randomTypes: [String])
}
