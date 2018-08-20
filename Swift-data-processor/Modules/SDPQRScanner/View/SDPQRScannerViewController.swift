//
//  QRScannerDPQRScannerViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 19/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit
import AVFoundation

class SDPQRScannerViewController: UIViewController, SDPQRScannerViewInput, SDPViewExternalConfiguratorProtocol {
    
    var output: SDPQRScannerViewOutput!
    var externalConfigurator: SDPViewExternalConfigurator?
    @IBOutlet weak var unicodeSwith: UISwitch!
    
    // MARK: Camera
    var session:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    
    // MARK: Outlets
    @IBOutlet weak var cameraCaptureView: UIView!

    // MARK: actions
    
    @IBAction func unicodeSwithValueChanged(_ sender: UISwitch) {
        output.set(unicodeSupportTo: sender.isOn)
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    deinit {
        if let input = session?.inputs.first as? AVCaptureDeviceInput {
            session?.removeInput(input)
        }
        
        if let output = session?.outputs.first as? AVCaptureMetadataOutput {
            session?.removeOutput(output)
        }
        
        session?.stopRunning()
    }

    // MARK: Camera
    func setupCamera(delegate: AVCaptureMetadataOutputObjectsDelegate) {
        if session != nil {
            return
        }
        
        session = AVCaptureSession()
        
        if session != nil{
            
            session!.sessionPreset = AVCaptureSession.Preset.high
            let device = AVCaptureDevice.default(for: AVMediaType.video)
            var input:AVCaptureDeviceInput? = nil
            
            do {
                try input = AVCaptureDeviceInput.init(device: device!)
            } catch {
                print("Error initiate device input: \(error)")
            }
            
            if session!.canAddInput(input!) {
                session!.addInput(input!)
            }
            
            let newCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: session!)
            newCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            
            newCaptureVideoPreviewLayer.frame = view.bounds;
            videoPreviewLayer = newCaptureVideoPreviewLayer
            
            let captureMetadataOutput:AVCaptureMetadataOutput = AVCaptureMetadataOutput()
            
            session!.addOutput(captureMetadataOutput)
            
            let dispatchQueue:DispatchQueue = DispatchQueue(label: "capturingQueue")
            captureMetadataOutput.setMetadataObjectsDelegate(delegate, queue: dispatchQueue)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            self.cameraCaptureView.layer.addSublayer(newCaptureVideoPreviewLayer)
            weak var weakSelf = self
            
            DispatchQueue(label: "cameraSetupQueue", qos: DispatchQoS.userInitiated).async{
                weakSelf?.session!.startRunning()
            }
        }
    }
    
    
    // MARK: QRScannerViewInput
    func stopCamera(){
        session?.stopRunning()
    }
    
    func startCamera(){
        weak var weakSelf = self
        
        DispatchQueue(label: "cameraSetupQueue", qos: DispatchQoS.userInitiated).async{
            weakSelf?.session?.startRunning()
        }
    }
    
    func setupInitialState(unicodeSupport:Bool) {
        externalConfigurator?.configure(view: self)
        unicodeSwith.isOn = unicodeSupport
    }

}
