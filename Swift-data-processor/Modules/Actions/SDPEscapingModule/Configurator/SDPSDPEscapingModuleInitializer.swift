//
//  SDPSDPEscapingModuleSDPSDPEscapingModuleInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 03/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPEscapingModuleModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var sdpescapingmoduleViewController: SDPEscapingModuleViewController!

    override func awakeFromNib() {

        let configurator = SDPEscapingModuleModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: sdpescapingmoduleViewController)
    }

}
