//
//  SDPSDPWalkthroughModuleSDPSDPWalkthroughModuleInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 05/11/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPWalkthroughModuleModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var sdpwalkthroughmoduleViewController: SDPWalkthroughModuleViewController!

    override func awakeFromNib() {

        let configurator = SDPWalkthroughModuleModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: sdpwalkthroughmoduleViewController)
    }

}
