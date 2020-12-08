//
//  LoginController.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 28/10/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class LoginController: LoginControllerProtocol {
    
    struct LoginEntityModel: LoginEntityView {
        var name: String
        var pwd: String
    }
    
    var userData: LoginEntityModel?
    
    func getUserInfo() {
        
        // 1
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // 2
        let request: NSFetchRequest = User.fetchRequest()
               
        // 3
        do {
            let result = try context.fetch(request)
            userData = getModel(with: result.first!)
            view?.updateView(with: userData!)
        } catch let error as NSError {
            print("Error, no ha sido posible cargar user: \(error.userInfo)")
        }
    }
    
    var view: LoginViewProtocol?
    
    func validateUserWith(_ pwd: String) {
        guard let userPwd = userData?.pwd else { return }
        if pwd == userPwd {
            //let controller: UIViewController = AgendaWireFrame.buildAgendaTableModule()
            let controller: UIViewController = AgendaWireFrame.buildAgendaGridModule()
            view?.pushNewController(controller)
        } else {
            print("Pawwsord Incorrect")
        }
    }
    
    private func getModel(with data: NSManagedObject) -> LoginEntityModel? {
        guard let managedUser: User = data as? User else { return nil }
        guard let name: String = managedUser.name else { return nil }
        guard let pwd: String = managedUser.pwd else { return nil }
        
        let model: LoginEntityModel = LoginEntityModel(name: name, pwd: pwd)
        return model
    }
}
