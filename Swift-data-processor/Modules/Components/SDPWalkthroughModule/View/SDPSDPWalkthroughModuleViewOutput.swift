//
//  SDPWalkthroughModuleSDPSDPWalkthroughModuleViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 05/11/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPWalkthroughModuleViewOutput {

    func viewIsReady()
    func dismiss()
    func set(pageIndex: Int)
}
