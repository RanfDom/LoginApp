//
//  AgendaGridViewController.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 25/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

class AgendaGridViewController: UIViewController, LoadableViewController {

    static var storyboardFileName: String = "AgendaGridViewController"
    
    @IBOutlet weak var contactsCollectionView: UICollectionView!
    
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow: CGFloat = 2.0
    
    var controller: AgendaControllable?
    var contacts: [ContactItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsCollectionView.dataSource = self
        contactsCollectionView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        controller?.validateContacts()
    }
    
    @objc
    private func addAction() {
        //guard registerView.isHidden else { return }
        //showRegisterView(false)
    }
}

extension AgendaGridViewController: AgendaViewable {
    
    func presentAlert(with title: String, message: String) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showRegisterView(_ isHidden: Bool) {
        UIView.animate(withDuration: 0.5) {
            //self.registerView.isHidden = isHidden
        }
    }
    
    func updateView(with contacts: Contacts) {
        self.contacts = contacts
        self.contactsCollectionView.reloadData()
    }
}

extension AgendaGridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = contactsCollectionView.dequeueReusableCell(withReuseIdentifier: AgendaGridCell.reuseIdentifier, for: indexPath) as? AgendaGridCell else { return UICollectionViewCell() }
        cell.nameLabel.text = contacts[indexPath.row].name
        return cell
    }
}

extension AgendaGridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = ContactDetailWireframe.buildContactDetailModule()
        controller.contactDetail = ContactDetailVM(name: contacts[indexPath.row].name, phoneNumers: [])
        //self.navigationController?.pushViewController(controller, animated: true)
        self.present(controller, animated: true, completion: nil)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension AgendaGridViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let avaliableWidht = view.frame.width - paddingSpace
        let widhtPerItem = avaliableWidht/itemsPerRow
        
        return CGSize(width: widhtPerItem, height: widhtPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
