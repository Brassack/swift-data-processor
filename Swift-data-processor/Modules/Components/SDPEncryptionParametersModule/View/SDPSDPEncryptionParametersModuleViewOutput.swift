//
//  SDPEncryptionParametersModuleSDPPEncryptionParametersModuleViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 08/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPEncryptionParametersModuleViewOutput {

    func viewIsReady()
    func set(method: SDPCipherType)
    func set(keySize: Int)
    func pageViewIsready(_ pageViewController: Any)
    func didSelectPasswordBased()
    func didSelectRawBased()
}
