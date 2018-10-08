//
// SDPEncryptionViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

protocol SDPEncryptionViewOutput {
    
    func viewIsReady(parametersContainer: Any)
    func viewWillBePresented()
    func shareResult()
    func set(isConvertToText: Bool)
}
