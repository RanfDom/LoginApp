//
//  AgendaWireFrame.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 18/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

class AgendaWireFrame: AgendaWireframe {
    
    static func buildAgendaTableModule() -> Any {
        let view = UIStoryboard(name: "AgendaView", bundle: nil).instantiateViewController(identifier: "AgendaView") as! AgendaViewController
        let controller = AgendaController()
        
        controller.view = view
        view.controller = controller
        
        return view
    }
    
    static func buildAgendaGridModule() -> Any {
        let view = UIStoryboard(name: "AgendaGridView", bundle: nil).instantiateViewController(identifier: "AgendaGridView") as! AgendaGridViewController
        let controller = AgendaController()
        
        controller.view = view
        view.controller = controller
        
        return view
    }
}
