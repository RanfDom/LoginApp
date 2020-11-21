//
//  AgendaView.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 17/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

class AgendaViewController: UIViewController {
    
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var newContactTxtField: UITextField!
    
    var controller: AgendaControllable?
    var contacts: [ContactItem] = []
    
    @IBAction func registerButtonAction(_ sender: Any) {
        guard let name: String = newContactTxtField.text else { return }
        let contact: NewContactItem = NewContactItem(name: name)
        controller?.registerContact(with: contact)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactsTableView.delegate = self
        self.contactsTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        controller?.validateContacts()
    }
}

extension AgendaViewController: AgendaViewable {
    
    func presentAlert(with title: String, message: String) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showRegisterView(_ isHidden: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.registerView.isHidden = isHidden
        }
    }
    
    func updateTableView(with contacts: [ContactItem]) {
        self.contacts = contacts
        self.contactsTableView.reloadData()
    }
}

extension AgendaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // codigo para responder al tap de una celda
    }
}

extension AgendaViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // construcción de celdas
                
        guard let cell: AgendaTableViewCell = contactsTableView.dequeueReusableCell(withIdentifier: AgendaTableViewCell.reuseID, for: indexPath) as? AgendaTableViewCell else { return UITableViewCell()}
        
        let contact: ContactItem = self.contacts[indexPath.row]
            
        cell.nameLabel.text = contact.name
        cell.delegate = self
        
        return cell
    }
    
}

extension AgendaViewController: AgendaTableViewCellDelegate {
    func buttonGreetDidPressed(at indexPath: IndexPath) {
        controller?.greetUser(at: indexPath)
    }
}
