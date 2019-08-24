//
//  SDPPickerSingleOptionInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/2/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPPickerSingleOptionInput: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {
    
    struct Value {
        let valueDescription: String
        let value: Any
    }
    
    var pickerValues: [SDPPickerSingleOptionInput.Value]? {
        didSet{
            currentValue = pickerValues?.first
        }
    }
    var currentValue: SDPPickerSingleOptionInput.Value? {
        
        didSet{
            
            if currentValue == nil {
                currentValue = pickerValues?.first
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
            
            if let index = pickerValues?.firstIndex(where: {$0.valueDescription == currentValue.valueDescription}) {
                
                if index != picker?.selectedRow(inComponent: 0) {
                    
                    picker?.selectRow(index, inComponent: 0, animated: true)
                }
            }
        }
        return true
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
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
