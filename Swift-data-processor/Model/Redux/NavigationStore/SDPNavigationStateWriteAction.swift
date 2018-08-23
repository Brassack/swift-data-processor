//
//  SDPNavigationStateWriteAction.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/23/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit
import ReSwift

struct SDPNavigationStateWriteAction:Action {
    let nc: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        nc = navigationController
    }
}
