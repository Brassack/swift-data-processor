//
//  TexSDPTextRouterInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

protocol SDPTextRouterInput {

    func showTooLongTextFoQRError()
    func registerNavigationController(forView:Any?)
    func showScreen(forAction action:String)
    func qr()
    func returnToRootController()
}
