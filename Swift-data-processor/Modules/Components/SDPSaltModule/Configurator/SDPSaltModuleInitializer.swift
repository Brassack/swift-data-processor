//
// SDPSaltModuleInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPSaltModuleModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var sdpsaltmoduleViewController: SDPSaltModuleViewController!

    override func awakeFromNib() {

        let configurator = SDPSaltModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: sdpsaltmoduleViewController)
    }

}
