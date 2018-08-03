//
//  UIView+Shake.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/3/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

extension UIView {
    
    func shake(){
        
        weak var wself = self
        UIView.animate(withDuration: 0.03, animations: {
            
            wself?.transform = CGAffineTransform(translationX: 5, y: 0)
        }) { (finished) in
            
            UIView.animate(withDuration: 0.03, animations: {
                
                wself?.transform = CGAffineTransform(translationX: -5, y: 0)
            }, completion: { (finished) in
                
                UIView.animate(withDuration: 0.03, animations: {
                    
                    wself?.transform = CGAffineTransform(translationX: 5, y: 0)
                }, completion: { (finished) in
                    
                    UIView.animate(withDuration: 0.03, animations: {
                        
                        wself?.transform = CGAffineTransform.identity
                    }, completion: { (finished) in})
                })
            })
            
        }
    }
}
