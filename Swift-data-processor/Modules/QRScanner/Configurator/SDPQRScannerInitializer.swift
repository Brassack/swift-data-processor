//
//  DPQRScannerDPQRScannerInitializer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 19/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPQRScannerModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var qrscannerViewController: SDPQRScannerViewController!

    override func awakeFromNib() {

        let configurator = SDPQRScannerModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: qrscannerViewController)
    }

}
