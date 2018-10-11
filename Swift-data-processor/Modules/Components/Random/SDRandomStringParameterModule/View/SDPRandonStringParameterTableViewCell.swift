//
//  SDPRandonStringParameterTableViewCell.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRandonStringParameterTableViewCell: UITableViewCell, SDPTableViewCellConfigurable {
    
    var indexPath: IndexPath?
    var externalConfigurator: SDPTableViewCellExternalConfigurator?
    
    func configure(object: Any) {
        
        guard let row = object as? SDPTableViewDataSourceRow else {
            return
        }
        
        textLabel?.text = row.title
        detailTextLabel?.text = row.subtitle
        externalConfigurator?(self, object)
    }
}
