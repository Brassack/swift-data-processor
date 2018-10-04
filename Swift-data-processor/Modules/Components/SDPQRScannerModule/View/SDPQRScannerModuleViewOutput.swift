//
//  QRScannerDPQRScannerViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 19/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPQRScannerModuleViewOutput {

    func viewWIllBePresented()
    func viewIsReady()
    func set(unicodeSupportTo: Bool)
}
