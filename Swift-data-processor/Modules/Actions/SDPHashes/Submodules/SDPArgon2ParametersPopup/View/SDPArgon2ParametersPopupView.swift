//
//  SDPArgon2ParametersPopupSDPSDPArgon2ParametersPopupViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 27/08/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPArgon2ParametersPopupView: SDPArgon2ParametersPopupViewInput {

    var hashLengthTag = 1
    var memoryTag = 2
    var parallelismTag = 3
    
    var viewController: UIViewController {
        get{
            return alert
        }
    }
    
    var completionBlock: (() -> Void )?
    
    var output: (SDPArgon2ParametersPopupViewOutput & UITextFieldDelegate)!
    let alert = UIAlertController(title: "Argon2 Parameters", message: "Hash lenght (\(argon2MinHashLength)...\(argon2MaxHashLength))\n Memory (\(argon2MinMemory)...\(argon2MaxMemory))\n Parallelism (\(argon2MinParallelism)...\(argon2MaxParallelism))", preferredStyle: .alert)

    
    func setup(){
        output.viewIsReady(hashLenghtTag: self.hashLengthTag, memoryTag: self.memoryTag, parallelismTag: self.parallelismTag)
    }
    
    // MARK: SDPArgon2ParametersPopupViewInput
    func showError(forTextField textField: Any?, fallbackValue: String?) {
        guard let textField = textField as? UITextField else {
            return
        }
        
        textField.text = fallbackValue
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            textField.shake()
        }
    }
    
    func setupInitialState(){
        
    }
    
    func setup(parameters: SDPArgon2Parameters){

        alert.addTextField { [weak self] (textField) in
            
            textField.keyboardType = .numberPad
            textField.textAlignment = .center
            textField.tag = self?.hashLengthTag ?? 1
            textField.text = ("\(parameters.hashLength)")
            textField.placeholder = "Hash length"
            textField.delegate = self?.output
            self?.setupKeyboard(for: textField)
        }
        
        alert.addTextField { [weak self] (textField) in
            
            textField.keyboardType = .numberPad
            textField.textAlignment = .center
            textField.tag = self?.memoryTag ?? 2
            textField.text = ("\(parameters.memory)")
            textField.placeholder = "Memory"
            textField.delegate = self?.output
            self?.setupKeyboard(for: textField)
        }
        
        alert.addTextField { [weak self] (textField) in
            
            textField.keyboardType = .numberPad
            textField.textAlignment = .center
            textField.tag = self?.parallelismTag ?? 3
            textField.text = ("\(parameters.parallelism)")
            textField.placeholder = "Parralelism"
            textField.delegate = self?.output
            self?.setupKeyboard(for: textField)
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action) in
            self?.output.saveParameters()
            self?.completionBlock?()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] (action) in
            self?.completionBlock?()
        }))
        
    }
    
    func setupKeyboard(for textfield: UITextField){
        
        let button = UIButton(type: .system)
        button.setTitle("DONE", for: .normal)
        button.backgroundColor = UIColor.white
        button.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 45)
        button.addTarget(textfield, action: #selector(textfield.resignFirstResponder), for: .touchUpInside)
        textfield.inputAccessoryView = button
    }
}
