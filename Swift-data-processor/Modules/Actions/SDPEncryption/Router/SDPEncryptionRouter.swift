//
// SDPEncryptionRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPEncryptionRouter: SDPEncryptionRouterInput {

    func set(page: UIViewController, forPageController: UIPageViewController, direction: UIPageViewController.NavigationDirection){

        forPageController.setViewControllers([page], direction: direction, animated: true, completion: nil)
    }
    
    func share(data: Data) {
        
        SDPSharingPresenter().share(data: data)
    }
}
