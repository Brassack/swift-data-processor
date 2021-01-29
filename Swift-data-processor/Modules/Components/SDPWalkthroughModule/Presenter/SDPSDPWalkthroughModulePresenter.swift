//
//  SDPWalkthroughModuleSDPSDPWalkthroughModulePresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 05/11/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit

class SDPWalkthroughModulePresenter: SDPWalkthroughModuleModuleInput, SDPWalkthroughModuleViewOutput, SDPWalkthroughModuleInteractorOutput {

    weak var view: SDPWalkthroughModuleViewInput!
    var interactor: SDPWalkthroughModuleInteractorInput!
    var router: SDPWalkthroughModuleRouterInput!
    
    var slides: [(text: String, image: String)]!
    var slideFactory: ((Any, Int) -> Any?)!
    
    lazy var pagesDataSource: SDPPagesControllerDataSource? = {
        
        let pagesDataSource = SDPPagesControllerDataSource()
        pagesDataSource.viewControllerSource = { [weak self] (index) -> Any? in
            
            guard index >= 0 else { return nil }
            guard index < (self?.slides.count) ?? 0 else { return nil }
            guard let image = self?.slides[index].image else { return nil }
            
            return self?.slideFactory(image, index)
        }
        return pagesDataSource
    }()

    func set(pageIndex: Int) {
        
        guard pageIndex >= 0 else { return }
        guard pageIndex < slides.count else { return }
        
        let description = slides[pageIndex].text
        view.set(description: description)
        view.set(page: pageIndex)
    }
    
    
    func viewIsReady() {
        
        view.setupInitialState()
        if let pagesDataSource = pagesDataSource , let firstSlide = slides.first {
            view.set(pagesDataSource: pagesDataSource)
            view.set(description: firstSlide.text)
            view.set(page: 0)
            view.set(numberOfPages: slides.count)
        }
    }
    
    func dismiss() {
        
        UserDefaults.standard.set(true, forKey: SDPWalkthroughAccepted)
        UserDefaults.standard.synchronize()
        router.dismiss()
    }
}
