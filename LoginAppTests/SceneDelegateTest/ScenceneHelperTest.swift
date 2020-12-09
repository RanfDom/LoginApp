//
//  ScenceneHelperTest.swift
//  LoginAppTests
//
//  Created by Ranferi Dominguez Rios on 07/12/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import XCTest
@testable import LoginApp

class ScenceneHelperTest: XCTestCase {

    func testSceneDelegateShowSteps() {
        // Given
        let isOnboarding =  true
        let isRegistered = false
        
        // When
        let vc = SceneHelper.getInitialController(isOnboarding, isRegistered: isRegistered)
        
        // Then
        XCTAssertTrue(vc is PageViewController)
    }
    
    func testSceneDelegateShowStepsUserRegistered() {
        // Given
        let isOnboarding =  true
        let isRegistered = true
        
        // When
        let vc = SceneHelper.getInitialController(isOnboarding, isRegistered: isRegistered)
        
        // Then
        XCTAssertTrue(vc is LoadableViewController)
    }
    
    func testSceneDelegateShowLogin() {
        // Given
        let isOnboarding =  false
        let isRegistered = true
        
        // When
        let vc = SceneHelper.getInitialController(isOnboarding, isRegistered: isRegistered)
        
        // Then
        XCTAssertTrue(vc is LoginProtocols)
    }
    
    func testSceneDelegateShowRegister() {
        // Given
        let isOnboarding =  false
        let isRegistered = false
        
        // When
        let vc = SceneHelper.getInitialController(isOnboarding, isRegistered: isRegistered)
        
        // Then
        XCTAssertTrue(vc is RegisterViewProtocol)
    }

}
