//
//  SDPQRGeneratorSDPSDPQRGeneratorViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit

protocol SDPQRGeneratorViewInput: class {
    
    var output: SDPQRGeneratorViewOutput! {get set}
    
    func setupInitialState()
    func prepareFoorScreen()
    func show(qrImage: UIImage)
}
