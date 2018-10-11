//
//  SDPRandomNumberParameterModuleInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRandomNumberParameterModuleModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var sdrandomnumberparametermoduleViewController: SDPRandomNumberParameterModuleViewController!

    override func awakeFromNib() {

        let configurator = SDPRandomNumberParameterModuleModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: sdrandomnumberparametermoduleViewController)
    }

}
