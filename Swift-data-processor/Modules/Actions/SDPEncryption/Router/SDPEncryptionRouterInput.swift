//
// SDPEncryptionRouterInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPEncryptionRouterInput {

    func addParametersView(toView view: Any, controller: Any)
    func share(data:Data)
    func share(text: String)
    func show(errorMessage: String, in view: Any)
}
