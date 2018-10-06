//
// SDPTextViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPTextModuleViewInput: class {

    func setupInitialState()
    func prepareForScreen()
    func set(text:String?)
    func refreshInputActionsState()
}
