//
//  SDPSettingModuleRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 12/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit
//import StoreKit

class SDPSettingModuleRouter: SDPSettingModuleRouterInput {
    
    lazy var controllerForPresentation = UIApplication.shared.keyWindow?.rootViewController
    var completion: ((UIColor) -> Void)?
    var componentsStoryboard = UIStoryboard.components
    
    //MARK: SDPSettingModuleRouterInput
    func showColorPicker(color:Any, completion: @escaping (Any) -> Void) {
        
        guard let color = color as? UIColor else {
            return
        }
        
        self.completion = completion
        
        let vc = SDPColorPickerViewController()
        vc.color = color
        let nc = UINavigationController(rootViewController: vc)
        nc.navigationBar.isTranslucent = true
        nc.setNavigationBarHidden(false, animated: false)
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(colorSelected))
        
        controllerForPresentation?.present(nc, animated: true, completion: nil)
    }
    
    func showCredits() {
        
        let vc = componentsStoryboard.instantiateViewController(withIdentifier: String(describing: SDPCreditsTableViewController.self))
        
        let nc = UINavigationController(rootViewController: vc)
        nc.setNavigationBarHidden(false, animated: false)
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: vc, action: #selector(UIViewController.dismissFromParentAnimated))
        
        controllerForPresentation?.present(nc, animated: true, completion: nil)
    }
    
    func showSourceCode() {
        
        if let url = URL(string: "https://github.com/Brassack/swift-data-processor"),
            UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func showReview() {
        
        guard let writeReviewURL = URL(string: "https://itunes.apple.com/app/id1440320812?action=write-review") else {
            return
        }
        
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
//        SKStoreReviewController.requestReview()
    }
    
    //MARK: Color view controller helper
    @objc func colorSelected(){
        
        guard let nc = controllerForPresentation?.presentedViewController as? UINavigationController,
            let color = (nc.topViewController as? SDPColorPickerViewController)?.color
        else {
            controllerForPresentation?.dismiss(animated: true, completion: nil)
            return
        }
        
        UserDefaults.standard.set(color.hexValue, forKey: SDPThemeDefaultsKey)
        UserDefaults.standard.synchronize()
        
        controllerForPresentation?.dismiss(animated: true, completion: { [weak self] () in
            
            self?.completion?(color)
            self?.completion = nil
        })
    }
    
    
}
