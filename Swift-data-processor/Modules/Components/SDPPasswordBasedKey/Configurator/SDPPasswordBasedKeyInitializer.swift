//
// SDPPasswordBasedKeyInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPPasswordBasedKeyModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var sdppasswordbasedkeyViewController: SDPPasswordBasedKeyViewController!

    override func awakeFromNib() {

        let configurator = SDPPasswordBasedKeyModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: sdppasswordbasedkeyViewController)
    }

}
