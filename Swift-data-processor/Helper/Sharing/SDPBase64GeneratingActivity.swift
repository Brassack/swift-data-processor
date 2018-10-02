//
//  SDPBase64GeneratingActivity.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/2/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPBase64GeneratingActivity: UIActivity {

    var navigationController: UINavigationController?
    var storyboard = UIStoryboard.actions
    var encodedString: String
    
    init?(data: Data) {
        
        encodedString = data.base64EncodedString()
    }
    
    override var activityType: UIActivity.ActivityType? {
        get{
            return .copyToPasteboard
        }
    }
    
    override var activityTitle: String? {
        get{
            return "base64"
        }
    }
    
    override var activityImage: UIImage? {
        
        get{
            
            switch (UIScreen.main.traitCollection.userInterfaceIdiom) {
                
            case .pad:
                
                return UIImage(named: "base64-sharing-ipad")
            default:
                
                return UIImage(named: "base64-sharing")
            }
        }
    }
    
    override class var activityCategory: UIActivity.Category {
        get{
            return .action
        }
    }
    
    // TODO: Research
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        
    }
    
    override func perform() {
        
        guard var rootVC = UIApplication.shared.keyWindow?.rootViewController else {
            
            activityDidFinish(true)
            return
        }
        
        while let presented = rootVC.presentedViewController {
            rootVC = presented
        }
        
        let qrActivity = SDPQRGeneratingActivity(text: encodedString, qrStoryboard: storyboard)
        let activities = qrActivity == nil ? [] : [qrActivity!]
        let activityViewController = UIActivityViewController(activityItems: [encodedString], applicationActivities: activities)
        activityViewController.popoverPresentationController?.sourceView = rootVC.view // so that iPads won't crash
        
        rootVC.present(activityViewController, animated: true, completion: nil)
        
        
    }
    
}
