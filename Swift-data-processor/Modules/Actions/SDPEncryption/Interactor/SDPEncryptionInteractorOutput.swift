//
// SDPEncryptionInteractorOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPEncryptionInteractorOutput: class {

    func set(text: String)
    func set(data: Data)
    func set(isEncoding: Bool)
    func set(parameters: SDPEncryptionParameters?)
}
