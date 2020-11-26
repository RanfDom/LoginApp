//
//  ContactDetailViewController.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 24/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ContactDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var phoneNumberTable: UITableView!
    @IBOutlet weak var phoneTitleInputText: UITextField!
    @IBOutlet weak var phoneNumberInputText: UITextField!
    
    var contactDetail: ContactDetailVM?
    var dbContact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberTable.dataSource = self
        phoneNumberTable.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
        dbContact = getContactData()
        contactDetail = ContactDetailVM(contact: dbContact!)
        nameLabel.text = contactDetail?.name
        
        addButton.addTarget(self, action: #selector(addPhoneNumber), for: .touchUpInside)
    }
    
    @objc
    func addPhoneNumber() {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let phoneNum = PhoneNumber(context: context)
        phoneNum.title = phoneTitleInputText.text
        phoneNum.number = phoneNumberInputText.text
        
        dbContact?.phoneNumber = NSSet.init(array: [phoneNum])
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error.userInfo)")
        }
        
        contactDetail = ContactDetailVM(contact: dbContact!)
    }

    func getContactData() -> Contact? {
        // 1
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // 2
        let request: NSFetchRequest = Contact.fetchRequest()
               
        // 3
        do {
            let result = try context.fetch(request)
            let managedResult = result as [Contact]
            
            if managedResult.isEmpty { return nil }
            
            for resultItem in managedResult {
                if resultItem.name == contactDetail?.name {
                    return resultItem
                }
            }
            
        } catch let error as NSError {
            print("Error, no ha sido posible cargar user: \(error.userInfo)")
        }
        return nil
    }
}

extension ContactDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactDetail?.phoneNumers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Default") else { return UITableViewCell() }
        cell.textLabel?.text = "\(contactDetail?.phoneNumers[indexPath.row].title ?? "No title"): \(contactDetail?.phoneNumers[indexPath.row].number ?? "No number")"
        return cell
    }
    
    
}
