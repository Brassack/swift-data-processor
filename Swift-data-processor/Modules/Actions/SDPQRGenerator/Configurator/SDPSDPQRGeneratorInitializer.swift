//
//  SDPSDPQRGeneratorSDPSDPQRGeneratorInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPQRGeneratorModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var sdpqrgeneratorViewController: SDPQRGeneratorViewController!

    override func awakeFromNib() {

        let configurator = SDPQRGeneratorModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: sdpqrgeneratorViewController)
    }

}
