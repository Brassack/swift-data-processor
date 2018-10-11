//
//  SDPRandomModuleRouterInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 09/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPRandomModuleRouterInput {

    func set(page: Any, forPageController: Any, direction: SDRandomModulePresenter.Direction)
    func share(text: String)
    func share(data: Data)
}
