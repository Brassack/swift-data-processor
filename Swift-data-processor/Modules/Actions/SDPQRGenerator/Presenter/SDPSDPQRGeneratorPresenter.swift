//
//  SDPQRGeneratorSDPSDPQRGeneratorPresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit

class SDPQRGeneratorPresenter: SDPQRGeneratorModuleInput, SDPQRGeneratorViewOutput, SDPQRGeneratorInteractorOutput {

    weak var view: SDPQRGeneratorViewInput!
    var interactor: SDPQRGeneratorInteractorInput!
    var router: SDPQRGeneratorRouterInput!
    
    var qrImageSize: CGSize? {
        didSet{
            
            guard let size = qrImageSize else {
                return
            }
            
            guard let image = qrImage else {
                return
            }
            
            guard image.size != qrImageSize else {
                return
            }
            
            weak var wself = self

            DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
                
                guard let resultImage = wself?.fit(image: image, toSize: size) else {
                    return
                }
                
                DispatchQueue.main.async {
                    wself?.qrImage = resultImage
                    wself?.view.show(qrImage: resultImage)
                }
            }
        }
    }
    var qrImage: UIImage?

    // MARK: SDPQRGeneratorViewOutput
    
    func share() {
        if let image = qrImage {
            router.share(image: image)
        }
    }
    
    func viewIsReady() {
        interactor.requestClipboardData()
        view.setupInitialState()
    }
    
    func viewWillBePresented(qrSize: CGSize) {
        qrImageSize = qrSize
        view.prepareFoorScreen()
    }
    
    // MARK: Internal
    func fit(image:UIImage, toSize size:CGSize) -> UIImage {
        
        if image.size == size {
            return image
        }else{
            guard let convertedImage = image.scaled(to: size) else {
                return image
            }
            return convertedImage
        }
    }
    
    // MARK: SDPQRGeneratorInteractorOutput
    func set(text: String) {
        
        weak var wself = self
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            
            guard let baseImage = text.qrImage() else {
                return
            }
            
            guard let size = wself?.qrImageSize else {
                DispatchQueue.main.async {
                    wself?.view.show(qrImage: baseImage)
                }
                return
            }
            
            guard let resultImage = wself?.fit(image: baseImage, toSize: size) else{
                return
            }
            
            DispatchQueue.main.async {
                wself?.qrImage = resultImage
                wself?.view.show(qrImage: resultImage)
            }
        }
    }
}
