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
        controller?.validateContacts()
    }
}

extension AgendaViewController: AgendaViewable {
    
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

extension AgendaViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
