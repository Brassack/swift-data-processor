//
//  c.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/9/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPQRScannerModuleViewDismissButtonExternalConfigurator: SDPViewExternalConfigurator {
    override func configure(view: UIViewController) {
        let button = UIButton(type: .system)
        button.setTitle("❮", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        button.layer.cornerRadius = 35
        button.clipsToBounds = true
        button.addTarget(view.navigationController, action: #selector(UIViewController.dismissFromParentAnimated), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.view.addSubview(button)
        
        let views = ["button": button]
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[button(70)]", metrics: nil, views: views)
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[button(70)]", metrics: nil, views: views)
        
        view.view.addConstraints(vConstraints)
        view.view.addConstraints(hConstraints)
        
        view.view.layoutSubviews()
    }
}
