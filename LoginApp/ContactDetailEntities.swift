//
//  ContactDetailEntities.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 24/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation

struct ContactDetailVM {
    let name: String
    let phoneNumers: [PhoneNumberVM]
}

extension ContactDetailVM {
    init( contact: Contact) {
        self.name = contact.name ?? ""
        
        var numbers: [PhoneNumberVM] = []
        
        for item in contact.phoneNumber?.allObjects ?? [] {
            guard let numItem = item as? PhoneNumber else { continue }
            numbers.append(PhoneNumberVM(phoneNumber: numItem))
        }
        
        self.phoneNumers = numbers
    }
}

struct PhoneNumberVM {
    let title: String
    let number: String
}

extension PhoneNumberVM {
    init( phoneNumber: PhoneNumber ) {
        self.title = phoneNumber.title ?? ""
        self.number = phoneNumber.number ?? ""
    }
}
