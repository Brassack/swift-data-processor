//
//  SDPSettingOpenSourceTableViewCell.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/12/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPSettingOpenSourceTableViewCell: UITableViewCell, SDPTableViewCellConfigurable {

    var indexPath: IndexPath?
    var externalConfigurator: SDPTableViewCellExternalConfigurator?
    
    func configure(object: Any) {
        
        let color = (UIApplication.shared.delegate as? AppDelegate)?.configurator.theme.actionColor ?? UIColor(hex:0x177F01)
        
        textLabel?.textColor = color
    }
}
