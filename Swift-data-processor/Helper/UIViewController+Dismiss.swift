//
//  UIViewController+Dismiss.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/23/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit


extension UIViewController {
    
    @IBAction func popNavigationControllerAnimated() {
        navigationController?.popViewController(animated: true)
    }
    
}
