//
//  SDPSDPSettingModuleSDPSDPSettingModuleConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 12/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPSettingModuleModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPSettingModuleViewControllerMock()
        let configurator = SDPSettingModuleModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPSettingModuleViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPSettingModulePresenter, "output is not SDPSettingModulePresenter")

        let presenter: SDPSettingModulePresenter = viewController.output as! SDPSettingModulePresenter
        XCTAssertNotNil(presenter.view, "view in SDPSettingModulePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDPSettingModulePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPSettingModuleRouter, "router is not SDPSettingModuleRouter")

        let interactor: SDPSettingModuleInteractor = presenter.interactor as! SDPSettingModuleInteractor
        XCTAssertNotNil(interactor.output, "output in SDPSettingModuleInteractor is nil after configuration")
    }

    class SDPSettingModuleViewControllerMock: SDPSettingModuleViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
