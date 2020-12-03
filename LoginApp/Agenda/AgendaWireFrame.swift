//
//  AgendaWireFrame.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 18/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

class AgendaWireFrame: AgendaWireframeProtocol {
    
    static func buildAgendaTableModule() -> AgendaViewController {
        let view = AgendaViewController.instantiate()
        let controller = AgendaController()
        
        controller.view = view
        view.controller = controller
        
        return view
    }
    
    static func buildAgendaGridModule() -> AgendaGridViewController {
        let view = AgendaGridViewController.instantiate()
        let controller = AgendaController()
        
        controller.view = view
        view.controller = controller
        
        return view
    }
}
