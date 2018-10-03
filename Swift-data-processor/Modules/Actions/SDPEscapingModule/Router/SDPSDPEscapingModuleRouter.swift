//
//  SDPEscapingModuleSDPSDPEscapingModuleRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 03/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

class SDPEscapingModuleRouter: SDPEscapingModuleRouterInput {
    
    func share(text: String) {
        
        SDPSharingPresenter().share(string: text)
    }
}
