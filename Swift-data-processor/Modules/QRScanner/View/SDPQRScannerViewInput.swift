//
//  QRScannerDPQRScannerViewInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 19/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import AVFoundation

protocol SDPQRScannerViewInput: class {

    /**
        @author Dmytro Platov
        Setup initial state of the view
    */

    func setupInitialState()
    func setupCamera(delegate: AVCaptureMetadataOutputObjectsDelegate)
    func stopCamera()
    func startCamera()
}
