//
//  SDPRawKeyModuleSDPSDPRawKeyModuleViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRawKeyModuleViewController: UIViewController, SDPRawKeyModuleViewInput {
    
    var output: SDPRawKeyModuleViewOutput!
    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var shareButton: UIButton!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyTextField.delegate = output
        output.viewIsReady()
    }

    // MARK: User actions
    @IBAction func dice(_ sender: Any) {
        
        output.generateRandomKey()
    }
    
    @IBAction func qr(_ sender: Any) {
        
        output.scanFromQR()
    }
    
    @IBAction func share(_ sender: Any) {
        
        output.share()
    }
    
    // MARK: SDPRawKeyModuleViewInput
    func set(key: String?) {
        
        keyTextField.text = key
        shareButton.isEnabled = (key?.count ?? 0) > 0
    }
    
    func setupInitialState() {
        
        keyTextField.addDoneButton()
    }
}
