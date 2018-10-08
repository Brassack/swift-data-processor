//
//  SDPEncryptionParametersModuleSDPSDPEncryptionParametersModuleViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 08/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPEncryptionParametersModuleViewController: UIViewController, SDPEncryptionParametersModuleViewInput {

    var output: SDPEncryptionParametersModuleViewOutput!

    @IBOutlet weak var keySizeTextField: SDPPickerSingleOptionInput!
    @IBOutlet weak var methodTextField: SDPPickerSingleOptionInput!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "KeyPagesViewController", let destination = segue.destination as? UIPageViewController {
            output.pageViewIsready(destination)
        }
    }

    //MARK: user actions
    @IBAction func keySizeChaged(_ sender: SDPPickerSingleOptionInput) {
        guard let size = sender.currentValue?.value as? Int else {
            return
        }
        
        output.set(keySize: size)
    }
    
    @IBAction func mechodChanged(_ sender: SDPPickerSingleOptionInput) {
        
        guard let method = sender.currentValue?.value as? SDPCipherType else {
            return
        }
        
        output.set(method: method)
    }
    
    @IBAction func keySegmentChanged(_ sender: Any) {
        
        guard let sender = sender as? UISegmentedControl else {
            return
        }
        
        if sender.selectedSegmentIndex == 0 {
            output.didSelectPasswordBased()
        }else{
            output.didSelectRawBased()
        }
    }
    

    // MARK: SDPEncryptionParametersModuleViewInput
    func setupInitialState() {
    }
    
    
    func set(methodPickerValues values: [SDPPickerSingleOptionInput.Value], defaultValue: SDPPickerSingleOptionInput.Value?) {
        
        methodTextField.pickerValues = values
        methodTextField.currentValue = defaultValue
    }
    
    func set(keySizesPickerValues values: [SDPPickerSingleOptionInput.Value], defaultValue: SDPPickerSingleOptionInput.Value?) {
        
        keySizeTextField.pickerValues = values
        keySizeTextField.currentValue = defaultValue
    }
}
