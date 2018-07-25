//
//  UIStoryboard+App.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/25/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

extension UIStoryboard {
    class var accesory: UIStoryboard {get{
        return UIStoryboard(name: "Accessory", bundle: nil)
    }}
    
    class var main: UIStoryboard {get{
        return UIStoryboard(name: "Main", bundle: nil)
    }}
}
