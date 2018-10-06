//
// SDPEscapingModuleViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 03/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPEscapingModuleViewInput: class {

    /**
        @author Dmytro Platov
        Setup initial state of the view
    */

    func setupInitialState()
    func prepareForScreen()
    func setup(pickerOptions: [SDPPickerSingleOptionInput.Value], defaultValue: SDPPickerSingleOptionInput.Value?)
    func show(text: String?)
}
