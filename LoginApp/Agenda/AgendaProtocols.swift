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
}

protocol AgendaViewable {
    var controller: AgendaControllable? { get set }
    
    func showRegisterView(_ isHidden: Bool)
    func updateTableView(with contacts: [ContactItem])
}
