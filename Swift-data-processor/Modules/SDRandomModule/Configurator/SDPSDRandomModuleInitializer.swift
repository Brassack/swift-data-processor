//
//  SDPRandomModuleModuleInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 09/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRandomModuleModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var sdprandommoduleViewController: SDPRandomModuleViewController!

    override func awakeFromNib() {

        let configurator = SDPRandomModuleModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: sdprandommoduleViewController)
    }

}
