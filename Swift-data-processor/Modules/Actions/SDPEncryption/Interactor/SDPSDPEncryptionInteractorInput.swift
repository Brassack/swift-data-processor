//
//  SDPSDPEncryptionSDPSDPEncryptionInteractorInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPEncryptionInteractorInput {

    func requestClipboardData()
    func setupParameters(withKeySize: Int);
}
