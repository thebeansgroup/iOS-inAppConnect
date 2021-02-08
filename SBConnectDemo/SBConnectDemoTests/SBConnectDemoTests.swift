//
//  SBConnectDemoTests.swift
//  SBConnectDemoTests
//
//  Created by Jack Smith on 13/11/2020.
//

import XCTest
@testable import SBConnectDemo

class SBConnectDemoTests: XCTestCase {
    // MARK: - Properties
    
    var viewController: ViewController!
    var sbConnect: MockSBConnect.Type!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        viewController = ViewController()
        sbConnect = MockSBConnect.self
        viewController.sbConnect = sbConnect
    }
    
    // MARK: - Test Methods
    
    func testConfigureSetsBackgroundColor() {
        viewController.configure()
        
        XCTAssertEqual(viewController.view.backgroundColor, UIColor.white)
    }
    
    func testLayoutAddsConnectButton() {
        viewController.layout()
        
        let button = viewController.view.subviews.first as? UIButton
        XCTAssertNotNil(button)
        XCTAssertEqual(button?.titleLabel?.text, Constants.connectButtonText)
        XCTAssertEqual(button?.titleLabel?.textColor, UIColor.palette(.uiBlue300))
    }
    
    func testDidTapConnectCallsSBConnect() {
        viewController.didTapConnect()
        
        XCTAssertTrue(sbConnect.connectCalled)
    }
}

// MARK: - Constants

extension SBConnectDemoTests {
    private struct Constants {
        static let connectButtonText = "Connect"
    }
}
