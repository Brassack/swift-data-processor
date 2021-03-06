//
// SDPPasswordBasedKeyViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPPasswordBasedKeyViewInput: class {

    func setupInitialState()
    func set(password: String?)
    func set(rawKeyString: String?)
}
