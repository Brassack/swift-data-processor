//
//  SDPTextActionTableViewCell.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/3/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPTextActionTableViewCell: UITableViewCell, SDPTableViewCellConfigurable {
    
    var externalConfigurator: SDPTableViewCellExternalConfigurator?
    
    func configure(object: Any) {
        
        guard let row = object as? SDPTableViewDataSourceRow else {
            return
        }
        
        textLabel?.text = row.title
        externalConfigurator?(self, object)
    }
}
