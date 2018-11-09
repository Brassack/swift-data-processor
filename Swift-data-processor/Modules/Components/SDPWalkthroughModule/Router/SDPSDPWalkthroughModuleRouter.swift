//
//  SDPWalkthroughModuleSDPSDPWalkthroughModuleRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 05/11/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPWalkthroughModuleRouter: SDPWalkthroughModuleRouterInput {
    
    func dismiss() {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
