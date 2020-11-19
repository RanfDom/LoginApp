//
//  AgendaModel.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 17/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation

protocol ContactItem {
    var name: String { get set }
}

struct NewContactItem {
    let name: String
}

struct ContactData: ContactItem {
    var name: String
    
    let phoneNumber: String?
    let eMail: String?
}

extension ContactData {
    init(_ name: String) {
        self.name = name
        self.phoneNumber = nil
        self.eMail = nil
    }
}
