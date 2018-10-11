//
//  SDPRandomNumberParameterModuleViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRandomNumberParameterModuleViewController: UIViewController, UITextFieldDelegate, SDPRandomNumberParameterModuleViewInput {

    var output: SDPRandomNumberParameterModuleViewOutput!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var minTextField: UITextField!
    @IBOutlet weak var maxTextField: UITextField!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: SDRandomNumberParameterModuleViewInput
    func setupInitialState() {
        
        minTextField.addDoneButton()
        maxTextField.addDoneButton()
    }
    
    func set(result: String?) {
        resultLabel.text = result
    }
    
    func set(min: String) {
        minTextField.text = min
    }
    
    func set(max: String) {
        maxTextField.text = max
    }
    
    func showMaxError() {
        maxTextField.shake()
    }
    
    func showMinError() {
        maxTextField.shake()
    }
    

    //MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else {
            return
        }
        
        if textField === minTextField {
            
            output.set(min: text)
        }else{
            
            output.set(max: text)
        }
    }
}
