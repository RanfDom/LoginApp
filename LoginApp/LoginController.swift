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
        let request: NSFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
               
        // 3
        do {
            let result = try context.fetch(request)
            let managedResult = result as [NSManagedObject]
            userData = getModel(with: managedResult.first!)
            view?.updateView(with: userData!)
        } catch let error as NSError {
            print("Error, no ha sido posible cargar user: \(error.userInfo)")
        }
        
    }
    
    var view: LoginViewProtocol?
    
    func validateUserWith(_ pwd: String) {
        guard let userPwd = userData?.pwd else { return }
        if pwd == userPwd {
            print("Continue Login")
        } else {
            print("Pawwsord Incorrect")
        }
    }
    
    private func getModel(with data: NSManagedObject) -> LoginEntityModel? {
        guard let name: String = data.value(forKey: "name") as? String else { return nil }
        guard let pwd: String = data.value(forKey: "pwd") as? String else { return nil }
        
        let model: LoginEntityModel = LoginEntityModel(name: name, pwd: pwd)
        return model
    }
}
