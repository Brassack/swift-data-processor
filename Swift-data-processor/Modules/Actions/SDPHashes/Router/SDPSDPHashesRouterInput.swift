//
//  SDPHashesSDPSDPHashesRouterInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

protocol SDPHashesRouterInput {

    var navigationController:UINavigationController? {get set}
    
    func scanQR(stores:SDPReduxStores)
    func returnTo(view: UIViewController)
}
