//
//  SDPSettingModuleInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 12/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPSettingModuleModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var sdpsettingmoduleViewController: SDPSettingModuleViewController!

    override func awakeFromNib() {

        let configurator = SDPSettingModuleModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: sdpsettingmoduleViewController)
    }

}
