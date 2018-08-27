//
//  SDPArgon2ParametersPopupModuleBuilder.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/27/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPArgon2ParametersPopupModuleBuilder {

    class func buildArgon2ParametersPopup(completionBlock:@escaping () -> Void) -> SDPArgon2ParametersPopupView {
        
        let view = SDPArgon2ParametersPopupView()
        view.completionBlock = completionBlock
        
        let configurator = SDPArgon2ParametersPopupModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: view)
        
        return view
    }
}
