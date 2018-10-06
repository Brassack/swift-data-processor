//
//  SDPArgon2ParametersPopupSDPArgon2ParametersPopupViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 27/08/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPArgon2ParametersPopupViewInput: class {

    func showError(forTextField textField: Any?, fallbackValue: String?)
    func setupInitialState()
    func setup(parameters: SDPArgon2Parameters);
}
