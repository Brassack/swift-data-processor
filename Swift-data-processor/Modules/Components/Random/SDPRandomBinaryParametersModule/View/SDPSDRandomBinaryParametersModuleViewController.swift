//
//  SDRandomBinaryParametersModuleSDPRandomBinaryParametersModuleViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRandomBinaryParametersModuleViewController: UIViewController, UITextFieldDelegate, SDPRandomBinaryParametersModuleViewInput {

    var output: SDPRandomBinaryParametersModuleViewOutput!
    @IBOutlet weak var hexRepresentationLabel: UILabel!
    @IBOutlet weak var countTextField: UITextField!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: SDRandomBinaryParametersModuleViewInput
    func setupInitialState() {
        
        countTextField.addDoneButton()
    }
    
    func showError() {
        
        countTextField.shake()
    }
    
    func set(count: String) {
        
        countTextField.text = count
    }
    
    func set(hex: String) {
        
        hexRepresentationLabel.text = hex
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        output.set(count: textField.text)
    }
}
