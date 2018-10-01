//
//  SDPEncryptionSDPSDPEncryptionRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPEncryptionRouter: SDPEncryptionRouterInput {

    func set(page: UIViewController, forPageController: UIPageViewController, direction: UIPageViewControllerNavigationDirection){
        /*
         [self.pageViewController setViewControllers:@[[self pageViewControllerForIndex:0]]
         direction:UIPageViewControllerNavigationDirectionForward
         animated:YES
         completion:nil];
         */
        forPageController.setViewControllers([page], direction: direction, animated: true, completion: nil)
    }
}
