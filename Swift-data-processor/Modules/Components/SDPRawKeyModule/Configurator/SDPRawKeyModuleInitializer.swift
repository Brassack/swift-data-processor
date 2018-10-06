//
// SDPRawKeyModuleInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRawKeyModuleModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var sdprawkeymoduleViewController: SDPRawKeyModuleViewController!

    override func awakeFromNib() {

        let configurator = SDPRawKeyModuleModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: sdprawkeymoduleViewController)
    }

}
