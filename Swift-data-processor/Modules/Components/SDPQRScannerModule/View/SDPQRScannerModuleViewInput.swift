//
//  QRScannerDPQRScannerViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 19/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import AVFoundation

protocol SDPQRScannerModuleViewInput: class {
    
    func prepareForScreen()
    func setupInitialState(unicodeSupport:Bool)
    func setupCamera(delegate: AVCaptureMetadataOutputObjectsDelegate)
    func stopCamera()
    func startCamera()
}
