//
//  QRScannerDPQRScannerPresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 19/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import AVFoundation

class SDPQRScannerPresenter:NSObject, SDPQRScannerModuleInput, SDPQRScannerViewOutput, SDPQRScannerInteractorOutput, AVCaptureMetadataOutputObjectsDelegate {
    
    weak var view: SDPQRScannerViewInput!
    var interactor: SDPQRScannerInteractorInput!
    var router: SDPQRScannerRouterInput!
    
    var text: String? = nil
    var isForceSupportingUnicode = true {
        didSet{
            UserDefaults.standard.set(!isForceSupportingUnicode, forKey: "isNotSupportingUnicode")
            UserDefaults.standard.synchronize()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: QRScannerViewOutput
    func set(unicodeSupportTo unicodeSupport: Bool) {
        isForceSupportingUnicode = unicodeSupport
    }
    
    func viewIsReady() {
        
        #if targetEnvironment(simulator)
        let action = SDPSetTextAction(string:"simulator")
        SDPReduxStores.shared.clipboard.dispatch(action)
        return
        #endif
        
        isForceSupportingUnicode = !UserDefaults.standard.bool(forKey: "isNotSupportingUnicode")
        view.setupInitialState(unicodeSupport: isForceSupportingUnicode)
        setupCameraCapturing()
    }
    
    //MARK: AVCaptureMetadataOutputObjectsDelegate
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            if object.type == AVMetadataObject.ObjectType.qr, let string = object.stringValue {

                var resultString = string
                
                if isForceSupportingUnicode, let decodedString = string.unicodeDecodedString {
                    resultString = decodedString
                }
                
                guard (text != resultString || text == nil) else {
                    return
                }
                
                text = resultString
                
                DispatchQueue.main.async {
                    let action = SDPSetTextAction(string:resultString)
                    SDPReduxStores.shared.clipboard.dispatch(action)
                }
                
            }
        }
    }
    
    //MARK: Camera
    func setupCameraCapturing()  {
        
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        switch authorizationStatus {
        case .authorized:
            
            NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive(_:)), name: .UIApplicationDidBecomeActive, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(willResignActive(_:)), name: .UIApplicationWillResignActive, object: nil)
            view.setupCamera(delegate: self)
            
        case .notDetermined:
            weak var weakSelf = self
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                DispatchQueue.main.async {
                    weakSelf?.setupCameraCapturing()
                }
            })
        case .denied:
            router.show(alert: (title: "Enable camera to scan QR", message:nil))
        case .restricted:
            router.show(alert: (title: "Something went wrong. Please enable camera to scan QR", message:nil))
        }
    }
    
    //MARK: Application lifecycle
     @objc func didBecomeActive(_ notification:NSNotification) {
        view.startCamera()
     }
     
     @objc func willResignActive(_ notification:NSNotification) {
        view.stopCamera()
    }
}
