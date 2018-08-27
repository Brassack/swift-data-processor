//
//  SDPApplicationThemeConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/24/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPApplicationThemeConfigurator: NSObject {
    class func configure(actionColor: UIColor){
        
        UIButton.appearance().tintColor = actionColor
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = actionColor
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor = actionColor
        UITextField.appearance().textColor = actionColor
        UITextField.appearance().tintColor = actionColor
        UITabBar.appearance().tintColor = actionColor
        UISwitch.appearance().onTintColor = actionColor
    }
}
