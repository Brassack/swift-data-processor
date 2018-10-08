//
//  SDPEncryptionParametersModuleSDPSDPEncryptionParametersModuleViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 08/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPEncryptionParametersModuleViewInput: class {

    func setupInitialState()
    func set(methodPickerValues: [SDPPickerSingleOptionInput.Value], defaultValue: SDPPickerSingleOptionInput.Value?)
    func set(keySizesPickerValues: [SDPPickerSingleOptionInput.Value], defaultValue: SDPPickerSingleOptionInput.Value?)
}
