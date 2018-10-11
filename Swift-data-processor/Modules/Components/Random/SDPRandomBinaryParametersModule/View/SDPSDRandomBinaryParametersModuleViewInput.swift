//
//  SDRandomBinaryParametersModuleSDPRandomBinaryParametersModuleViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPRandomBinaryParametersModuleViewInput: class {
    
    func setupInitialState()
    func set(count: String)
    func set(hex: String)
    func showError()
}
