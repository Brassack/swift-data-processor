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
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor = actionColor
        UITabBar.appearance().tintColor = actionColor
    }
}
