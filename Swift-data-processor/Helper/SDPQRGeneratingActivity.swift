//
//  SDPQRGeneratingActivity.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/27/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import ReSwift

class SDPQRGeneratingActivity: UIActivity {
    
    var navigationController: UINavigationController
    var storyboard: UIStoryboard
    var text: String
    var stores = SDPReduxStores.shared
    
    init(text: String, navigationController: UINavigationController, storyboard: UIStoryboard) {
        
        self.navigationController = navigationController
        self.storyboard = storyboard
        self.text = text
    }
    
    override var activityType: UIActivityType? {
        get{
            return .saveToCameraRoll
        }
    }
    
    override var activityTitle: String? {
        get{
            return "QR"
        }
    }
    
    override var activityImage: UIImage? {
        
        get{
            
            switch (UIScreen.main.traitCollection.userInterfaceIdiom) {
                
            case .pad:

                return UIImage(named: "qr-sharing-ipad")
            default:

                return UIImage(named: "qr-sharing")
            }
        }
    }
    
    override class var activityCategory: UIActivityCategory {
        get{
            return .action
        }
    }
    
    // TODO: Research
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        print("prepare \(activityItems)")
        
        let action = SDPMapStateWriteAction(key: "SDPQRGenerator", value: text)
        stores.mapStore.dispatch(action)
    }
    
    override func perform() {
        
        let vc = storyboard.instantiateViewController(withIdentifier: "SDPQRGeneratorViewController")
        navigationController.pushViewController(vc, animated: true)
        
        activityDidFinish(true)
    }
}
