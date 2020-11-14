//
//  LoginViewController.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 28/10/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import SDWebImage

class LoginViewController: UIViewController, LoginViewProtocol {
    var controller: LoginControllerProtocol?
    
    @IBOutlet weak var labelHello: UILabel!
    @IBOutlet weak var pwdInputText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func loginButtonAction(_ sender: Any) {
        controller?.validateUserWith(pwdInputText.text ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pwdInputText.isSecureTextEntry = true
        pwdInputText.delegate = self
        loginButton.setTitle("Login", for: .normal)
        
        if !isFBValidToken() {
            addFBLoginButton()
        } else {
            greetUser()
        }
        
        controller?.getUserInfo()
    }
    
    func present(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    private func isFBValidToken() -> Bool {
        let isTokenExist = AccessToken.current?.tokenString != nil
        let isTokenValid = !(AccessToken.current?.isExpired ?? true)
        return isTokenExist && isTokenValid
    }
    
    private func addFBLoginButton() {
        let fbLoginButton = FBLoginButton()
        fbLoginButton.delegate = self
        fbLoginButton.permissions = ["public_profile", "email"]
        fbLoginButton.center = self.view.center
        view.addSubview(fbLoginButton)
    }
    
    private func greetUser() {
        let requestFields = "email, first_name, picture"
        
        GraphRequest.init(graphPath: "me", parameters: ["fields": requestFields]).start { (connection, result, error) in
            guard let resultDict = result as? [String: Any],
                let image = resultDict["picture"] as? [String: Any],
                let imageData = image["data"] as? [String: Any],
                let imageURL = imageData["url"] as? String else { return }
            
            self.profileImage.isHidden = false
            self.profileImage.sd_setImage(with: URL(string: imageURL), placeholderImage: nil) { (resImage, error, _, _) in
                self.profileImage.image = resImage!
            }
        }
    }
    
    func updateView(with model: LoginEntityView) {
        labelHello.text = model.name
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("User logged out")
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print("FaceBook login error: \(error.localizedDescription)")
        } else if let result = result {
            // move to another controller
            print("UserLogged")
            let declinedPermissions = result.declinedPermissions
            let grantedPermissions = result.grantedPermissions
            let fbToken = result.token?.tokenString ?? ""
        }
    }
    
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
