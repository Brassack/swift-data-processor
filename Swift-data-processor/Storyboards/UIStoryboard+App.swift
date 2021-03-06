//
//  UIStoryboard+App.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/25/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    class var main: UIStoryboard {get{
        return UIStoryboard(name: "Main", bundle: nil)
    }}
    
    class var actions: UIStoryboard {get{
        return UIStoryboard(name: "Actions", bundle: nil)
    }}
    
    class var components: UIStoryboard {get{
        return UIStoryboard(name: "Components", bundle: nil)
    }}
    
    class var randomComponents: UIStoryboard {get{
        return UIStoryboard(name: "RandomComponents", bundle: nil)
    }}
}
