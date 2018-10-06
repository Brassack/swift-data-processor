//
// SDPEscapingModuleViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 03/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPEscapingModuleViewController: UIViewController, SDPEscapingModuleViewInput {

    var output: SDPEscapingModuleViewOutput!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var typeInput: SDPPickerSingleOptionInput!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillBePresented()
    }
    
    //MARK: user action
    @IBAction func actionChaged(_ sender: UISegmentedControl) {
        
        output.set(isEncoding: sender.selectedSegmentIndex == 0)
    }
    
    @IBAction func share(_ sender: Any) {
        
        output.share()
    }
    
    @IBAction func typeChanged(_ sender: SDPPickerSingleOptionInput) {
        
        guard let type = sender.currentValue?.value as? SDPEscapingModuleInteractor.EscapingType else {
            return
        }
        
        output.set(type: type)
    }
    
    // MARK: SDPEscapingModuleViewInput
    func setupInitialState() {
        
    }
    
    func prepareForScreen() {
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    func setup(pickerOptions options: [SDPPickerSingleOptionInput.Value], defaultValue: SDPPickerSingleOptionInput.Value?) {
        
        typeInput.pickerValues = options
        if defaultValue != nil {
            typeInput.currentValue = defaultValue
        }
    }
    
    func show(text: String?) {
        
        outputTextView.text = text
    }
}
