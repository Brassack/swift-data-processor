//
//  SDPPEncryptionParametersModuleSDPPEncryptionParametersModuleInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 08/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPEncryptionParametersModuleModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var sdpencryptionparametersmoduleViewController: SDPEncryptionParametersModuleViewController!

    override func awakeFromNib() {

        let configurator = SDPEncryptionParametersModuleModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: sdpencryptionparametersmoduleViewController)
    }

}
