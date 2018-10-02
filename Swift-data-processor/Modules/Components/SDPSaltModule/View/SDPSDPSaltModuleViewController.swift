//
//  SDPSaltModuleSDPSDPSaltModuleViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPSaltModuleViewController: UIViewController, SDPSaltModuleViewInput {

    var output: SDPSaltModuleViewOutput!
    @IBOutlet weak var saltTextField: UITextField!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        saltTextField.delegate = output
        output.viewIsReady()
    }

    // MARK: User actions
    @IBAction func dice(_ sender: Any) {
        
        output.generateRandomSalt()
    }
    
    @IBAction func qr(_ sender: Any) {
        output.scanSaltFromQR()
    }

    // MARK: SDPSaltModuleViewInput
    func set(salt: String?) {
        
        saltTextField.text = salt
    }

    func setupInitialState() {
        
        saltTextField.addDoneButton()
    }
}
