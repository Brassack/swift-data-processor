//
//  SDPWalkthroughModuleSDPSDPWalkthroughModuleViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 05/11/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPWalkthroughModuleViewInput: class {
    func setupInitialState()
    func set(pagesDataSource dataSource: SDPPagesControllerDataSource)
    func set(description: String)
    func set(page: Int)
    func set(numberOfPages: Int)
}
