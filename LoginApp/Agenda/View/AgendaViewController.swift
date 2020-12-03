//
//  AgendaView.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 17/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

class AgendaViewController: UIViewController, LoadableViewController {

    static var storyboardFileName: String = "AgendaViewController"
    
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var newContactTxtField: UITextField!
    
    var controller: AgendaControllable?
    var contacts: Contacts = []
    
    @IBAction func registerButtonAction(_ sender: Any) {
        guard let name: String = newContactTxtField.text else { return }
        let contact: NewContactItem = NewContactItem(name: name)
        controller?.registerContact(with: contact)
        showRegisterView(true)
        newContactTxtField.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactsTableView.delegate = self
        self.contactsTableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        controller?.validateContacts()
    }

    @objc
    private func addAction() {
        guard registerView.isHidden else { return }
        showRegisterView(false)
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
    
    func updateView(with contacts: Contacts) {
        self.contacts = contacts
        self.contactsTableView.reloadData()
    }
}

extension AgendaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ContactDetailWireframe.buildContactDetailModule() as! ContactDetailViewController
        controller.contactDetail = ContactDetailVM(name: contacts[indexPath.row].name, phoneNumers: [])
        //self.navigationController?.pushViewController(controller, animated: true)
        self.present(controller, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleterAction = UIContextualAction(style: .destructive, title: "Borrar") { (_ , _, complete ) in
            // manejar la eliminación de algún item
            self.controller?.deleteContact(at: indexPath)
            complete(true)
        }
        
        deleterAction.backgroundColor = .red
        
        let config = UISwipeActionsConfiguration(actions: [deleterAction])
        config.performsFirstActionWithFullSwipe = true
        
        return config
    }
}

extension AgendaViewController: AgendaTableViewCellDelegate {
    func buttonGreetDidPressed(at indexPath: IndexPath) {
        controller?.greetUser(at: indexPath)
    }
}
