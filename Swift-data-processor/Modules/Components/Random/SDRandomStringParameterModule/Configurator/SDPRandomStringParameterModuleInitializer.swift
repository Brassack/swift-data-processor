//
//  SDPRandomStringParameterModuleInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRandomTextParameterModuleModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var sdrandomstringparametermoduleViewController: SDPRandomTextParameterModuleViewController!

    override func awakeFromNib() {

        let configurator = SDPRandomTextParameterModuleModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: sdrandomstringparametermoduleViewController)
    }

}
