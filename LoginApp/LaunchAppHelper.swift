//
//  LaunchAppHelper.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 02/12/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

struct LaunchAppHelper {
    static func getInitialController(_ isOnboardgin: Bool, isRegisteredUser: Bool) -> UIViewController {
        if isOnboardgin {
            /*
             Mostrar tutorial solo la primera vez / la primera actualización
             */
            return PageViewController.instantiate()
        } else {
            return isRegisteredUser ? LoginWireFrame.buildLoginModule() : RegisterWireFrame.buildRegisterModule()
        }
    }
}
