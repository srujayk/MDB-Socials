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
    var loginButton: ColorButton!
    var signupButton: ColorButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.mdb_blue
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
        emailTextField.layer.cornerRadius = Constants.corner_radius
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
        passwordTextField.layer.cornerRadius = Constants.corner_radius
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.textColor = UIColor.black
        passwordTextField.isSecureTextEntry = true
        self.view.addSubview(passwordTextField)
    }
    
    func setupButtons() {
        loginButton = ColorButton(frame: CGRect(x: view.frame.width * 0.3, y: view.frame.height * 0.65, width: view.frame.width * 0.4, height: 50))
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setup()
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        self.view.addSubview(loginButton)

        signupButton = ColorButton(frame: CGRect(x: view.frame.width * 0.3, y: view.frame.height * 0.75, width: view.frame.width * 0.4, height: 50))
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setup()
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        self.view.addSubview(signupButton)
    }
    
    func loginButtonClicked(sender: UIButton!) {
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

