//
//  SDPSDPWalkthroughModuleSDPSDPWalkthroughModuleConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 05/11/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPWalkthroughModuleModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPWalkthroughModuleViewControllerMock()
        let configurator = SDPWalkthroughModuleModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPWalkthroughModuleViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPWalkthroughModulePresenter, "output is not SDPWalkthroughModulePresenter")

        let presenter: SDPWalkthroughModulePresenter = viewController.output as! SDPWalkthroughModulePresenter
        XCTAssertNotNil(presenter.view, "view in SDPWalkthroughModulePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDPWalkthroughModulePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPWalkthroughModuleRouter, "router is not SDPWalkthroughModuleRouter")

        let interactor: SDPWalkthroughModuleInteractor = presenter.interactor as! SDPWalkthroughModuleInteractor
        XCTAssertNotNil(interactor.output, "output in SDPWalkthroughModuleInteractor is nil after configuration")
    }

    class SDPWalkthroughModuleViewControllerMock: SDPWalkthroughModuleViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
