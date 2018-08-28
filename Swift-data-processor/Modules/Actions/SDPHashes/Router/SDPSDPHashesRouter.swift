//
//  SDPHashesSDPSDPHashesRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPHashesRouter: SDPHashesRouterInput, StoreSubscriber {

    weak var navigationController : UINavigationController?
    var accesoryStoryboard: UIStoryboard!
    var actionsStoryboard: UIStoryboard!
    var popupReference: Any?
    var stores = SDPReduxStores.shared
    
    init() {
        stores.navigationStore.subscribe(self)
    }
    
    func newState(state: SDPNavigationState) {
        navigationController = state.navigationController
    }

    func returnTo(view: UIViewController) {
        navigationController?.popToViewController(view, animated: true)
    }
    
    func scanQR() {
        let vc = accesoryStoryboard.instantiateViewController(withIdentifier: "SDPQRScannerViewController")
        
        if let vc = vc as? SDPViewExternalConfiguratorProtocol{
            vc.externalConfigurator = SDPQRScannerViewBackButtonExternalConfigurator()
        }

        navigationController?.pushViewController(vc, animated: true)
    }
    
    func argon2Parameters() {
        
        let popup = SDPArgon2ParametersPopupModuleBuilder.buildArgon2ParametersPopup {[weak self] in
            self?.popupReference = nil
        }
        
        popupReference = popup
        
        navigationController?.present(popup.viewController, animated: true, completion: nil)
    }
    
    func shareSalt(_ salt: String){
        
        guard let nc = navigationController else {
            return
        }
        
        let qrActivity = SDPQRGeneratingActivity(text: salt, navigationController: nc, storyboard: actionsStoryboard)
        let activityViewController = UIActivityViewController(activityItems: [salt], applicationActivities: [qrActivity])
        activityViewController.popoverPresentationController?.sourceView = nc.view // so that iPads won't crash
        
//        activityViewController.use
        // present the view controller
        nc.present(activityViewController, animated: true, completion: nil)
    }
}
