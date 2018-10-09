//
//  SDPApplicationThemeConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/24/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPApplicationConfigurator: NSObject {
    var theme: SDPApplicationTheme = SDPApplicationTheme()
    
    func configureTheme(actionColor: UIColor){
        
        theme.actionColor = actionColor
        UISegmentedControl.appearance().tintColor = actionColor
        UIButton.appearance().tintColor = actionColor
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = actionColor
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor = actionColor
        UITextField.appearance().textColor = actionColor
        UITextField.appearance().tintColor = actionColor
        UITabBar.appearance().tintColor = actionColor
        UISwitch.appearance().onTintColor = actionColor
    }
    
    func configureMenu(){

        if let originalMethod = class_getInstanceMethod(UITextView.self, #selector(UITextView.canPerformAction(_:withSender:))),
            let swizzledMethod = class_getInstanceMethod(UITextView.self, #selector(UITextView._canPerformAction(_:withSender:))) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
        
        if let originalMethod = class_getInstanceMethod(UITextField.self, #selector(UITextField.canPerformAction(_:withSender:))),
            let swizzledMethod = class_getInstanceMethod(UITextField.self, #selector(UITextField._canPerformAction(_:withSender:))) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
        
        let base64 = UIMenuItem(title: "Share binary", action: #selector(UITextView.shareBinary))
        let qrScan = UIMenuItem(title: "Scan QR", action: #selector(UITextView.qrScan))        
        let share = UIMenuItem(title: "Share", action: #selector(UITextView.share))

        UIMenuController.shared.menuItems = [base64, share, qrScan]
    }
}
