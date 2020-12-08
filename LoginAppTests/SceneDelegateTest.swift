//
//  SceneDelegateTest.swift
//  LoginAppTests
//
//  Created by Ranferi Dominguez Rios on 02/12/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit
import XCTest

@testable import LoginApp

class SceneDelegateTest: XCTestCase {
    func testPagerController() {
        let isOnboarding: Bool = true
        let isRegisteredUser: Bool = false
        
        let controller = LaunchAppHelper.getInitialController(isOnboarding, isRegisteredUser: isRegisteredUser)
        
        XCTAssertTrue(controller is PageViewController)
    }
}
