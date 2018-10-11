//
//  SDPRandomModuleRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 09/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit

class SDPRandomModuleRouter: SDPRandomModuleRouterInput {
    
    func set(page: Any, forPageController: Any, direction: SDRandomModulePresenter.Direction) {
        
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
    
    func share(text: String){
        
        SDPSharingPresenter().share(string: text)
    }
    
    func share(data: Data) {
        
        SDPSharingPresenter().share(data: data)
    }
    
}
