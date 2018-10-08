//
// SDPEncryptionViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPEncryptionViewInput: class {

    func setupInitialState()
    func prepareForScreen()
    func set(state: SDPEncryptionViewController.SDEncryptionState)
    func setConvertOption(visible: Bool, isConvert: Bool)
    func set(title: String?)
}
