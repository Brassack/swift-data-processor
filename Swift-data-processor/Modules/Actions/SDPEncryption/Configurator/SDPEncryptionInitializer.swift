//
// SDPEncryptionInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPEncryptionModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var sdpencryptionViewController: SDPEncryptionViewController!

    override func awakeFromNib() {

        let configurator = SDPEncryptionModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: sdpencryptionViewController)
    }

}
