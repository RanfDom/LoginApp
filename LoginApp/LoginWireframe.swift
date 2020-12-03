//
//  LoginWireframe.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 28/10/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

class LoginWireFrame: LoginWireframeProtocol {
    
    static func buildLoginModule() -> LoginViewController {
        let viewController = LoginViewController.instantiate()
        let logincController = LoginController()
        
        logincController.view = viewController
        viewController.controller = logincController
        
        return viewController
    }

}
