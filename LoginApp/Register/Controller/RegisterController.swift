//
//  RegisterController.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 28/10/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RegisterController: RegisterControllerProtocol {
    var view: RegisterViewProtocol?
    
    func registerUser(_ name: String, pwd: String) {
        
        // 1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // 2
        let user = User(context: context)
//        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
//        let usr = NSManagedObject(entity: entity, insertInto: context)
        
        // 3
        user.name = name
        user.pwd = pwd
//        usr.setValue(name, forKey: "name")
//        usr.setValue(pwd, forKey: "pwd")
        
        // 4
        do {
            try context.save()
            sendSuccesAlert(with: name)
        } catch let error as NSError {
            print("No se puede guardar el usuario. Eror:\(error.userInfo)")
        }
//        UserDefaults.standard.set(name, forKey: "name")
//        UserDefaults.standard.set(pwd, forKey: "pwd")
    }

    func sendSuccesAlert(with name: String) {
        let alert = UIAlertController(title: "Registro Exitoso", message: "\(name.capitalized)", preferredStyle: .alert)
        view?.present(alert: alert)
    }
}
