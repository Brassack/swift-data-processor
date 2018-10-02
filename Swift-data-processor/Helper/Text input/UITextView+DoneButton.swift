//
//  UITextView+DoneButton.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/1/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

extension UITextView {
    
    func addDoneButton() {
        
        let button = UIButton(type: .system)
        button.setTitle("DONE", for: .normal)
        button.backgroundColor = UIColor.white
        button.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 45)
        button.addTarget(self, action: #selector(self.resignFirstResponder), for: .touchUpInside)
        inputAccessoryView = button
    }
}
