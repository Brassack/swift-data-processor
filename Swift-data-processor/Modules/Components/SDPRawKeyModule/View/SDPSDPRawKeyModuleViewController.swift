//
//  SDPRawKeyModuleSDPSDPRawKeyModuleViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRawKeyModuleViewController: UIViewController, SDPRawKeyModuleViewInput, UITextViewDelegate {
    
    var output: SDPRawKeyModuleViewOutput!
    @IBOutlet weak var keyTextView: UITextView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyTextView.delegate = self
        output.viewIsReady()
    }

    // MARK: User actions
    @IBAction func dice(_ sender: Any) {
        
        output.generateRandomKey()
    }
    
    @IBAction func qr(_ sender: Any) {
        
        output.scanFromQR()
    }
    
    // MARK: SDPRawKeyModuleViewInput
    func set(key: String?) {
        
        keyTextView.text = key
    }
    
    func setupInitialState() {
        
        keyTextView.addDoneButton()
    }
    
    //MARK: UITextFieldDelegate
    func textViewDidEndEditing(_ textView: UITextView) {
        
        output.set(key: textView.text)
    }
}
