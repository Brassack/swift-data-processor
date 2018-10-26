//
//  SDPSettingModuleRouterInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 12/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPSettingModuleRouterInput {

    func showColorPicker(color: Any, completion: @escaping (Any) -> Void)
    func showCredits()
    func showReview()
    func showSourceCode()
}
