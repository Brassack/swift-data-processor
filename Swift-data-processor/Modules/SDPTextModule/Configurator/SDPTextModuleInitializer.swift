//
//  DPTexSDPTextInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

class SDPTextModuleInitializer: NSObject {

    @IBOutlet weak var textViewController: SDPTextModuleViewController!

    override func awakeFromNib() {

        let configurator = SDPTextModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: textViewController)
    }
}
