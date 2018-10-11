//
//  SDRandomModuleSDPRandomModulePresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 09/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit

class SDRandomModulePresenter: SDRandomModuleModuleInput, SDPRandomModuleViewOutput, SDPRandomModuleInteractorOutput {

    weak var view: SDPRandomModuleViewInput!
    var interactor: SDPRandomModuleInteractorInput!
    var router: SDPRandomModuleRouterInput!
    
    var pagesViewController: Any?
    var pages: [Page]?
    var currentPage: Int = 0
    var state: SDPRandomParametersState?

    
    //MARK: SDRandomModuleViewOutput
    func share() {
        guard let state = state else {
            return
        }
        
        switch state.selectedType {
        case .number:
            
            router.share(text: String(state.number))
        case .text:
            
            switch state.selectedTextSubtype {
            case .uuid:
                
                router.share(text: state.uuid)
            case .text:
                
                router.share(text: state.text)
            case .loremIpsum:
                
                router.share(text: state.loremIpsum)
            }
        case .binary:
            
            router.share(data: state.binary)
        }
    }
    
    func random() {
        interactor.random()
    }
    
    func set(typeId: Int) {
        
        guard typeId >= 0,
            let pages = pages,
            typeId < pages.count,
            let type = SDPRandomParametersState.RandomType(rawValue: typeId),
            let pagesViewController = pagesViewController
            else {
            return
        }
        
        let page = pages[typeId]
        
        guard let pageVC = page.factory() else {
            return
        }
        
        var directions = SDRandomModulePresenter.Direction.forward
        if currentPage > typeId {
            directions = SDRandomModulePresenter.Direction.reverse
        }
        
        router.set(page: pageVC, forPageController: pagesViewController, direction: directions)
        currentPage = typeId
        interactor.set(type: type)
    }
    
    func set(pagesViewController: Any?) {
        self.pagesViewController = pagesViewController
    }

    func viewIsReady() {

        view.setupInitialState()
        interactor.requestData()
        
        var titles = [String]()
        
        for page in pages ?? [] {
            titles.append(page.type.title())
        }
        
        view.set(randomTypes: titles)
        
        set(typeId: SDPRandomParametersState.RandomType.allCases.first?.rawValue ?? 0)
    }
    
    //MARK: SDRandomModuleInteractorOutput
    
    func set(state: SDPRandomParametersState?) {
        
        self.state = state
    }
}

extension SDRandomModulePresenter {
    
    enum Direction {
        case forward
        case reverse
    }
    
    public typealias Page = (type: SDPRandomParametersState.RandomType, factory: (() -> Any?))
}
