//
//  RegisterWireFrame.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 28/10/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

class RegisterWireFrame: RegisterWireframeProtocol {
    
    static func buildRegisterModule() -> RegisterViewController {
        let view = RegisterViewController.instantiate()
        let controller = RegisterController()
        
        controller.view = view
        view.controller = controller
        
        return view
    }
}
