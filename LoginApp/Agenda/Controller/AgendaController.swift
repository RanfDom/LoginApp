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
    
    var userContacts: [ContactData] = []
    
    // Obtener los contactos de la base de datos y peridr actualizar la vista
    private func getContacts() -> [ContactData] {
        var contacts: [ContactData] = []
        
        // 1
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // 2
        let request: NSFetchRequest = Contact.fetchRequest()
               
        // 3
        do {
            let result = try context.fetch(request)
            let managedResult = result as [NSManagedObject]
            
            if managedResult.isEmpty { return contacts }
            
            for resultItem in managedResult {
                let name: String = resultItem.value(forKey: "name") as? String ?? ""
                contacts.append(ContactData(name))
            }
            
        } catch let error as NSError {
            print("Error, no ha sido posible cargar user: \(error.userInfo)")
        }

        return contacts
    }
}

extension AgendaController: AgendaControllable {
    
    func validateContacts() {
        DispatchQueue.main.async { [weak self] in
            guard let contacts = self?.getContacts() else { return }
            self?.userContacts = contacts
            if contacts.isEmpty {
                self?.view?.showRegisterView(false)
            } else {
                self?.view?.updateView(with: contacts)
            }
        }
    }
    
    func registerContact(with data: NewContactItem) {
        
        // 1 - Appdelegate & context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // 2 -
        let contact = Contact(context: context)
        // 3
//        usr.setValue(data.name, forKey: "name") // KVC -> Key Value Coding
        contact.name = data.name

        // 4
        do {
            try context.save()
//            userContacts.append(ContactData(data.name))
//            view?.updateTableView(with: userContacts)
        } catch let error as NSError {
            print("No se puede guardar el usuario. Eror:\(error.userInfo)")
        }
        validateContacts()
    }
    
    func greetUser(at indexPath: IndexPath) {
        let contact: ContactData = userContacts[indexPath.row]
        
        DispatchQueue.main.async { [weak self] in
            self?.view?.presentAlert(with: "Hola", message: "Hola \(contact.name)")
        }
    }

    func deleteContact(at indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest = Contact.fetchRequest()

        do {
            let contactsData = try context.fetch(fetchRequest)

            for contact in contactsData {
                if contact.name == userContacts[indexPath.row].name {
                    context.delete(contact)
                }
            }

            do {
                try context.save()
                self.validateContacts()
            } catch let error as NSError {
                print("Could not save: \(error.userInfo)")
            }

        } catch let error as NSError {
            print("Error: \(error.userInfo)")
        }
    }
}
