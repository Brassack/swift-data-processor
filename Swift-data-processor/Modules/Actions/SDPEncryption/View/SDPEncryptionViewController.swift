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
  
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var parametersContainerView: UIView!
    @IBOutlet weak var convertToTextContainerVioew: UIView!
    @IBOutlet weak var convertOptionSwith: UISwitch!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady(parametersContainer: parametersContainerView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillBePresented()
    }

    //MARK: user actions
    @IBAction func share(_ sender: Any) {
        
        output.shareResult()
    }
    
    @IBAction func convertToTextStateChanged(_ sender: UISwitch) {
        
        output.set(isConvertToText: sender.isOn)
    }
    
    // MARK: SDPEncryptionViewInput
    func set(title: String?) {
        self.title = title
    }
    
    func setConvertOption(visible: Bool, isConvert: Bool){
        
        convertToTextContainerVioew.isHidden = !visible
        convertOptionSwith.isOn = isConvert
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
}
