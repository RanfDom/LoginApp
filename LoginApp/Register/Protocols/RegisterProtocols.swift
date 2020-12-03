//
//  RegisterProtocols.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 28/10/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

// MARK: View to Controller

protocol RegisterControllerProtocol {
    var view: RegisterViewProtocol? { get set }

    func registerUser(_ name: String, pwd: String)
}

// MARK: Controller to View
protocol RegisterViewProtocol {
    var controller: RegisterControllerProtocol? { get set }
    
    func present(alert: UIAlertController)
}

// MARK: Wireframe
protocol RegisterWireframeProtocol: class {
    static func buildRegisterModule() -> RegisterViewController
}
