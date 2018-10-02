//
//  UIViewController+ChildViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 9/18/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func configureChildViewController(childController: UIViewController, onView: UIView?) {
        
        var holderView = self.view
        
        if let onView = onView {
            holderView = onView
        }
        
        addChild(childController)
        holderView?.addSubview(childController.view)
        constrainViewEqual(holderView: holderView!, view: childController.view)
        childController.didMove(toParent: self)
    }
    
    
    func constrainViewEqual(holderView: UIView, view: UIView) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                        toItem: holderView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                           toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                         toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                          toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)
        
        holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
    }
}
