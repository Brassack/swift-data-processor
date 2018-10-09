//
// SDPPasswordBasedKeyRouterInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

protocol SDPPasswordBasedKeyRouterInput {

    func showSaltView(intoView: UIView, forParent: UIViewController)
    func share(data: Data)
}
