//
//  QRScannerDPQRScannerModuleInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 19/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import Foundation

protocol SDPQRScannerModuleInput: class {
    
    var interactor: SDPQRScannerInteractorInput! {get set}
}
