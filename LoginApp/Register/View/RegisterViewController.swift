//
//  RegisterViewController.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 28/10/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController, RegisterViewProtocol {
    var controller: RegisterControllerProtocol?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var activeField : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        nameTextField.delegate = self
        pwdTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        contentView.addGestureRecognizer(tap)
    }
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 1.0) {
            self.registerButton.backgroundColor = .blue
        }
        
        UIView.animate(withDuration: 2.0, animations: {
            self.registerButton.backgroundColor = .red
        }) { _ in
            self.registerUser()
        }
    }
    
    private func registerUser() {
        guard let name = nameTextField.text,
            let pwd = pwdTextField.text else { return }

        controller?.registerUser(name, pwd: pwd)
    }
    
    func present(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        activeField?.resignFirstResponder()
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        guard let info = notification.userInfo else { return }
        
        self.scrollView.isScrollEnabled = true
        
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height, right: 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRec: CGRect = self.view.frame
        aRec.size.height -= keyboardSize!.height
        
        if let activeField = self.activeField {
            if ( !aRec.contains(activeField.frame.origin) ) {
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        
        guard let info = notification.userInfo else { return }
        
        self.scrollView.isScrollEnabled = false
        
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardSize!.height, right: 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeField?.resignFirstResponder()
        return true
    }
}
