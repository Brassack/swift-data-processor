//
// SDPQRGeneratorViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import CoreGraphics

protocol SDPQRGeneratorViewOutput {
    
    func viewIsReady()
    func viewWillBePresented(qrSize:CGSize)
    func share()
}
