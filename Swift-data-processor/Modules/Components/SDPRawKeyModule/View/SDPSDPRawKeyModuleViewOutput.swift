//
//  SDPRawKeyModuleSDPSDPRawKeyModuleViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

protocol SDPRawKeyModuleViewOutput:UITextFieldDelegate {

    /**
        @author Dmytro Platov
        Notify presenter that view is ready
    */

    func viewIsReady()
    
    func generateRandomKey()
    func share()
    func scanFromQR()
}
