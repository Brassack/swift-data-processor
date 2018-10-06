//
// SDPEncryptionViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPEncryptionViewController: UIViewController, SDPEncryptionViewInput {

    enum SDEncryptionState {
        
        case message(String)
        case processing
        case ready
    }
    
    var output: SDPEncryptionViewOutput!
    @IBOutlet weak var keySizeTextField: SDPPickerSingleOptionInput!
    @IBOutlet weak var methodTextField: SDPPickerSingleOptionInput!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillBePresented()
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
    
    @IBAction func share(_ sender: Any) {
        
        output.shareResult()
    }
    
    // MARK: SDPEncryptionViewInput
    func set(title: String?) {
        self.title = title
    }
    
    func prepareForScreen(){
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func set(state: SDEncryptionState) {
        
        switch state {
        case .message(let message):
            
            indicatorView.isHidden = true
            shareButton.isHidden = true
            statusLabel.text = message
        case .processing:
            
            statusLabel.text = nil
            shareButton.isHidden = true
            indicatorView.isHidden = false
        case .ready:
            
            statusLabel.text = nil
            shareButton.isHidden = false
            indicatorView.isHidden = true
        }
    }
    
    func setupInitialState() {
        
        set(state: .message("Please enter the key"))
        shareButton.isHidden = true
        indicatorView.isHidden = true
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
