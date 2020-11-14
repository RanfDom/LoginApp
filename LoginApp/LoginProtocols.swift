//
//  LoginProtocols.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 28/10/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

// MARK: View to Controller

protocol LoginControllerProtocol {
    var view: LoginViewProtocol? { get set }

    func validateUserWith(_ pwd: String)
    func getUserInfo()
}

// MARK: Controller to View
protocol LoginViewProtocol {
    var controller: LoginControllerProtocol? { get set }
    
    func updateView(with model: LoginEntityView)
    func present(alert: UIAlertController)
}

// MARK: Wireframe
protocol LoginWireframe: class {
    static func buildLoginModule() -> Any
}
