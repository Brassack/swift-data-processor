//
// SDPHashesInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPHashesModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var sdphashesViewController: SDPHashesViewController!

    override func awakeFromNib() {

        let configurator = SDPHashesModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: sdphashesViewController)
    }

}
