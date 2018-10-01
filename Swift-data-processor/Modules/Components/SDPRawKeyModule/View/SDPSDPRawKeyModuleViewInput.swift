//
//  SDPRawKeyModuleSDPSDPRawKeyModuleViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPRawKeyModuleViewInput: class {

    /**
        @author Dmytro Platov
        Setup initial state of the view
    */

    func setupInitialState()
    func set(key: String?)
}
