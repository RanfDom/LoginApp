//
//  AgendaProtocols.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 17/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation

protocol AgendaControllable {
    var view: AgendaViewable? { get set }
    
    func registerContact(with data: NewContactItem)
    func greetUser(at indexPath: IndexPath)
    func deleteContact(at indexPath: IndexPath)
    func validateContacts()
}

protocol AgendaViewable: Alertable {
    var controller: AgendaControllable? { get set }
    
    func showRegisterView(_ isHidden: Bool)
    func updateView(with contacts: Contacts)
}

protocol AgendaWireframeProtocol: class {
    static func buildAgendaTableModule() -> AgendaViewController
    static func buildAgendaGridModule() -> AgendaGridViewController
}
