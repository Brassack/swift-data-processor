//
//  SDPRandomBinaryParametersModuleSDPRandomBinaryParametersModuleInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRandomBinaryParametersModuleModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var sdprandombinaryparametersmoduleViewController: SDPRandomBinaryParametersModuleViewController!

    override func awakeFromNib() {

        let configurator = SDPRandomBinaryParametersModuleModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: sdprandombinaryparametersmoduleViewController)
    }

}
