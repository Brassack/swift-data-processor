//
// SDPPasswordBasedKeyViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPPasswordBasedKeyViewController: UIViewController, SDPPasswordBasedKeyViewInput {

    var output: SDPPasswordBasedKeyViewOutput!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var saltContainerView: UIView!
    @IBOutlet weak var rawValueDescription: UILabel!
    @IBOutlet weak var rawValueLabel: UILabel!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = output
        output.viewIsReady(saltContainerView: saltContainerView)
    }

    @IBAction func shareRawKey(_ sender: Any) {
        
        output.shareRawKey()
    }

    // MARK: SDPPasswordBasedKeyViewInput
    func setupInitialState() {
        
        passwordTextField.addDoneButton()
    }
    
    func set(password: String?) {
        
        passwordTextField.text = password
    }
    
    func set(rawKeyString: String?) {
        
        rawValueLabel.text = rawKeyString
        rawValueDescription.isHidden = (rawKeyString?.count ?? 0) == 0
    }
}
