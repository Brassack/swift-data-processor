//
//  SDPRandomNumberParameterModuleViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPRandomNumberParameterModuleViewInput: class {
    
    func setupInitialState()
    func set(result: String?)
    func set(min: String)
    func set(max: String)
    func showMaxError()
    func showMinError()
}
