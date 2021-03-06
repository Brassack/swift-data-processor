//
// SDPPasswordBasedKeyViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

protocol SDPPasswordBasedKeyViewOutput: UITextFieldDelegate {

    func viewIsReady(saltContainerView: UIView)
    func shareRawKey()
}
