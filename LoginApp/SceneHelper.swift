//
//  SceneHelper.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 07/12/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

struct SceneHelper {
    static func getInitialController(_ isOnboarding: Bool, isRegistered: Bool) -> UIViewController {
        guard !isOnboarding else { return PageViewController.instantiate() }
        if isRegistered {
            return LoginWireFrame.buildLoginModule()
        } else {
            return RegisterWireFrame.buildRegisterModule()
        }
    }
}
