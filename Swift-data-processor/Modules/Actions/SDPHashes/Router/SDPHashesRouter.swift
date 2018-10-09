//
// SDPHashesRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPHashesRouter: SDPHashesRouterInput, StoreSubscriber {

    weak var navigationController : UINavigationController?
    var qrStoryboard: UIStoryboard!
    var actionsStoryboard: UIStoryboard!
    var popupReference: Any?
    var stores = SDPReduxStores.shared
    
    init() {
        stores.navigationStore.subscribe(self)
    }
    
    func newState(state: SDPNavigationState) {
        navigationController = state.navigationController
    }

    func argon2Parameters() {
        
        let popup = SDPArgon2ParametersPopupModuleBuilder.buildArgon2ParametersPopup {[weak self] in
            self?.popupReference = nil
        }
        
        popupReference = popup
        
        navigationController?.present(popup.viewController, animated: true, completion: nil)
    }

    func share(hash: String){
        
        SDPSharingPresenter().share(string: hash)
    }
}
