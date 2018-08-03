//
//  UITableViewCellConfigurable.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/31/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

public typealias SDPTableViewCellExternalConfigurator = (UITableViewCell, Any) -> Void

protocol SDPTableViewCellConfigurable {
    var externalConfigurator: SDPTableViewCellExternalConfigurator? {get set}
    func configure(object: Any)
}
