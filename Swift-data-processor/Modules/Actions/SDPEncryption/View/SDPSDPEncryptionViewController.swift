//
//  SDPEncryptionSDPSDPEncryptionViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

struct SDPPickerValue {
    
    let valueDescription: String
    let value: Any
}

class SDPPickerSingleOptionInput: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerValues: [SDPPickerValue]? {
        didSet{
            currentValue = pickerValues?.last
        }
    }
    var currentValue: SDPPickerValue? {
        
        didSet{
            
            if currentValue == nil {
                currentValue = pickerValues?.last
            }
            
            text = currentValue?.valueDescription
        }
    }
    
    var picker: UIPickerView? {
        get{
            
            return inputView as? UIPickerView
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        inputView = picker
        
        addDoneButton()
    }
    
    override func becomeFirstResponder() -> Bool {
        
        super.becomeFirstResponder()
        if let currentValue = currentValue {
            
            if let index = pickerValues?.index(where: {$0.valueDescription == currentValue.valueDescription}) {
                
                if index != picker?.selectedRow(inComponent: 0) {
                    
                    picker?.selectRow(index, inComponent: 0, animated: true)
                }
            }
        }
        return true
    }
    
    //MARK: UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        currentValue = pickerValues?[row]
        sendActions(for: .valueChanged)
    }
    
    //MARK: UIPickerViewDataSource
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerValues?[row].valueDescription
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {

       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerValues?.count ?? 0
    }
}

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
    }
    
    // MARK: SDPEncryptionViewInput
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
    
    func set(methodPickerValues values: [SDPPickerValue], defaultValue: SDPPickerValue?) {
        
        methodTextField.pickerValues = values
        methodTextField.currentValue = defaultValue
    }
    
    func set(keySizesPickerValues values: [SDPPickerValue], defaultValue: SDPPickerValue?) {
        
        keySizeTextField.pickerValues = values
        keySizeTextField.currentValue = defaultValue
    }
}
