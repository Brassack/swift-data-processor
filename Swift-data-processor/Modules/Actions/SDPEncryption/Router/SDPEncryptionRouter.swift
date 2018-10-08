//
// SDPEncryptionRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPEncryptionRouter: SDPEncryptionRouterInput {
    
    var componentsStoryboard: UIStoryboard = UIStoryboard.components
    
    func addParametersView(toView view: Any, controller: Any) {
        
        guard let parent = controller as? UIViewController,
            let container = view as? UIView
        else {
            return
        }
        
        
        let child = componentsStoryboard.instantiateViewController(withIdentifier: String(describing: SDPEncryptionParametersModuleViewController.self))
        parent.configureChildViewController(childController: child, onView: container)
    }

    func share(text: String){
        
        SDPSharingPresenter().share(string: text)
    }
    
    func share(data: Data) {
        
        SDPSharingPresenter().share(data: data)
    }
    
    func show(errorMessage: String, in view: Any) {
        
        guard let vc = view as? UIViewController else{
            return
        }
        
        let alert = UIAlertController(title: "Ooops", message: errorMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        vc.present(alert, animated: true, completion: nil)
    }
}
