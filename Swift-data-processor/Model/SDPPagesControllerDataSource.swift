//
//  SDPPagesControllerDataSource.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/6/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPPagesControllerDataSource: NSObject, UIPageViewControllerDataSource {
    
    var viewControllerSource: ((Int) -> Any?)?
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return viewControllerSource?(viewController.view.tag - 1) as? UIViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return viewControllerSource?(viewController.view.tag + 1) as? UIViewController
    }
}
