//
//  UITextField+DoneButton.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 9/19/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addDoneButton() {
        
        let button = UIButton(type: .system)
        button.setTitle("DONE", for: .normal)
        button.backgroundColor = UIColor.systemBackground
        button.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 45)
        button.addTarget(self, action: #selector(self.resignFirstResponder), for: .touchUpInside)
        inputAccessoryView = button
    }
}
