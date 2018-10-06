//
// SDPQRGeneratorPresenter.swift
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
    private var isDataRequested = false
    
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
            

            DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async { [weak self] in
                
                guard let resultImage = self?.fit(image: image, toSize: size) else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.qrImage = resultImage
                    self?.view.show(qrImage: resultImage)
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
        view.setupInitialState()
    }
    
    func viewWillBePresented(qrSize: CGSize) {
        qrImageSize = qrSize
        view.prepareFoorScreen()
        
        if !isDataRequested {
            interactor.requestClipboardData()
            isDataRequested = true
        }
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
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {[weak self] in
            
            let errorMessage = "Something went wrong"
            
            guard let baseImage = text.qrImage() else {
                DispatchQueue.main.async {
                    self?.view.show(errorMessage: errorMessage)
                }
                return
            }
            
            guard let size = self?.qrImageSize else {
                DispatchQueue.main.async {
                    self?.view.show(qrImage: baseImage)
                }
                return
            }
            
            guard let resultImage = self?.fit(image: baseImage, toSize: size) else {
                DispatchQueue.main.async {
                    self?.view.show(errorMessage: errorMessage)
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.qrImage = resultImage
                self?.view.show(qrImage: resultImage)
            }
        }
    }
}
