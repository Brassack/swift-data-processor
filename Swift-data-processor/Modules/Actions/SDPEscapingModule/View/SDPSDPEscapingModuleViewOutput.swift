//
//  SDPEscapingModuleSDPSDPEscapingModuleViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 03/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPEscapingModuleViewOutput {

    /**
        @author Dmytro Platov
        Notify presenter that view is ready
    */

    func viewIsReady()
    func share()
    func set(isEncoding: Bool)
    func set(type: SDPEscapingModuleInteractor.EscapingType)
    func viewWillBePresented()
}
