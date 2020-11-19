//
//  AgendaController.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 17/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class AgendaController {
    var view: AgendaViewable?
    
    // Obtener los contactos de la base de datos y peridr actualizar la vista
    private func getContacts() {
        
    }
}

extension AgendaController: AgendaControllable {
    
    func registerContact(with data: NewContactItem) {
        
        // 1 - Appdelegate & context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // 2 -
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)!
        let usr = NSManagedObject(entity: entity, insertInto: context)
        
        // 3
        usr.setValue(data.name, forKey: "name")
        
        // 4
        do {
            try context.save()
            view?.showRegisterView(true)
            getContacts()
        } catch let error as NSError {
            print("No se puede guardar el usuario. Eror:\(error.userInfo)")
        }
    }
    
}
