//
//  SDPEncryptionParametersModuleSDPSDPEncryptionParametersModuleRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 08/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit

class SDPEncryptionParametersModuleRouter: SDPEncryptionParametersModuleRouterInput {

    //    func set(page: UIViewController, forPageController: UIPageViewController, direction: UIPageViewController.NavigationDirection){

    func set(page: Any, forPageController: Any, direction: SDPEncryptionParametersModulePresenter.Direction){
        
        guard let page = page as? UIViewController,
        let forPageController = forPageController as? UIPageViewController
        else {
            return
        }
        
        switch direction {
        case .forward:
            
            forPageController.setViewControllers([page], direction: .forward, animated: true, completion: nil)
        case .reverse:
            
            forPageController.setViewControllers([page], direction: .reverse, animated: true, completion: nil)
        }
    }
}
