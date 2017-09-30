//
//  LoginViewController.swift
//  MDBSocial
//
//  Created by Srujay Korlakunta on 9/26/17.
//  Copyright © 2017 Srujay Korlakunta. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var appTitle: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.45, green:0.74, blue:0.95, alpha:1.0)
        setupTitle()
        setupTextFields()
        setupButtons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func setupTitle() {
        appTitle = UILabel(frame: CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.2, width: view.frame.width * 0.8, height: view.frame.height * 0.2))
        appTitle.font = UIFont.systemFont(ofSize: 50, weight: 3)
        appTitle.adjustsFontSizeToFitWidth = true
        appTitle.textAlignment = .center
        appTitle.textColor = .white
        appTitle.text = "MDB Socials"
        view.addSubview(appTitle)
    }
    
    func setupTextFields() {
        emailTextField = UITextField(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.4, width: view.frame.width * 0.6, height: 50))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.placeholder = "  Email"
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = 3.0
        emailTextField.layoutIfNeeded()
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.masksToBounds = true
        emailTextField.textColor = UIColor.black
        self.view.addSubview(emailTextField)
        
        passwordTextField = UITextField(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.5, width: view.frame.width * 0.6, height: 50))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.placeholder = "  Password"
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 3.0
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.textColor = UIColor.black
        passwordTextField.isSecureTextEntry = true
        self.view.addSubview(passwordTextField)
    }
    
    func setupButtons() {
        loginButton = UIButton(frame: CGRect(x: view.frame.width * 0.3, y: view.frame.height * 0.65, width: view.frame.width * 0.4, height: 50))
        loginButton.layoutIfNeeded()
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(UIColor.blue, for: .normal)
        loginButton.layer.cornerRadius = 3.0
        loginButton.backgroundColor = UIColor(red:0.98, green:0.86, blue:0.36, alpha:1.0)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        self.view.addSubview(loginButton)

        signupButton = UIButton(frame: CGRect(x: view.frame.width * 0.3, y: view.frame.height * 0.75, width: view.frame.width * 0.4, height: 50))
        signupButton.layoutIfNeeded()
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setTitleColor(UIColor.blue, for: .normal)
        signupButton.layer.cornerRadius = 3.0
        signupButton.backgroundColor = UIColor(red:0.98, green:0.86, blue:0.36, alpha:1.0)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.layer.masksToBounds = true
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        self.view.addSubview(signupButton)
    }
    
    func loginButtonClicked(sender: UIButton!) {
        // FIRApp.configure()
        let email = emailTextField.text!
        //self.emailTextField.text = ""
        let password = passwordTextField.text!
        self.passwordTextField.text = ""
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error == nil {
                self.performSegue(withIdentifier: "toFeedFromLogin", sender: self)
            }
        })
    }
    
    func signupButtonClicked(sender: UIButton!) {
        performSegue(withIdentifier: "toSignupFromLogin", sender: self)
    }

}

