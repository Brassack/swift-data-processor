//
//  SDPQRGeneratorSDPQRGeneratorConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class QRGeneratorModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = QRGeneratorViewControllerMock()
        let configurator = QRGeneratorModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "QRGeneratorViewController is nil after configuration")
        XCTAssertTrue(viewController.output is QRGeneratorPresenter, "output is not QRGeneratorPresenter")

        let presenter: QRGeneratorPresenter = viewController.output as! QRGeneratorPresenter
        XCTAssertNotNil(presenter.view, "view in QRGeneratorPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in QRGeneratorPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is QRGeneratorRouter, "router is not QRGeneratorRouter")

        let interactor: QRGeneratorInteractor = presenter.interactor as! QRGeneratorInteractor
        XCTAssertNotNil(interactor.output, "output in QRGeneratorInteractor is nil after configuration")
    }

    class QRGeneratorViewControllerMock: QRGeneratorViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
