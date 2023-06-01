//
//  JarroyoEcomerceVentaUITestsLaunchTests.swift
//  JarroyoEcomerceVentaUITests
//
//  Created by MacBookMBP1 on 30/05/23.
//

import XCTest

final class JarroyoEcomerceVentaUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

//        let attachment = XCTAttachment(screenshot: app.screenshot())
//        attachment.name = "Launch Screen"
//        attachment.lifetime = .keepAlways
//        add(attachment)
//        let txtcorreo = app.textFields["Txt Correo"]
//        txtcorreo.exists
//        XCTAssertTrue(txtcorreo.exists)
        
        let boton = app.buttons["Ingresar"]
        XCTAssertTrue(boton.exists)
        boton.tap()
        
    }
}
