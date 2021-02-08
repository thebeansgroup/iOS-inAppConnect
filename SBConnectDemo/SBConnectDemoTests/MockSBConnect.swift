//
//  MockSBConnect.swift
//  SBConnectDemoTests
//
//  Created by Jack Smith on 16/11/2020.
//

@testable import SBConnectDemo
import SBConnect

class MockSBConnect: SBConnectProtocol {
    // MARK: - Test Properties
    
    static var connectCalled = false
    
    // MARK: - SBConnectProtocol
    
    static func connect(slug: String, countryCode: String, completion: @escaping SBConnectCompletionHandler) {
        connectCalled = true
    }
}
