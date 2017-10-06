//
//  SignUpViewController.swift
//  MDBSocial
//
//  Created by Srujay Korlakunta on 9/26/17.
//  Copyright © 2017 Srujay Korlakunta. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    var emailTextField: UITextField!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var nameTextField: UITextField!
    var profileImageView: UIImageView!
    var signupButton: ColorButton!
    var goBackButton: ColorButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.mdb_blue
        // Do any additional setup after loading the view.
        setupTextFields()
        setupButtons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func setupTextFields() {
        nameTextField = UITextField(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.2, width: view.frame.width * 0.6, height: 50))
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.placeholder = "  Full Name"
        nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        nameTextField.layer.borderWidth = 1.0
        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = Constants.corner_radius
        nameTextField.layer.masksToBounds = true
        nameTextField.textColor = UIColor.black
        self.view.addSubview(nameTextField)
        
        emailTextField = UITextField(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.3, width: view.frame.width * 0.6, height: 50))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.placeholder = "  Email"
        emailTextField.layoutIfNeeded()
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 1.0
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = Constants.corner_radius
        emailTextField.layer.masksToBounds = true
        emailTextField.textColor = UIColor.black
        self.view.addSubview(emailTextField)
        
        usernameTextField = UITextField(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.4, width: view.frame.width * 0.6, height: 50))
        usernameTextField.adjustsFontSizeToFitWidth = true
        usernameTextField.placeholder = "  Username"
        usernameTextField.layoutIfNeeded()
        usernameTextField.layer.borderColor = UIColor.lightGray.cgColor
        usernameTextField.layer.borderWidth = 1.0
        usernameTextField.backgroundColor = .white
        usernameTextField.layer.cornerRadius = Constants.corner_radius
        usernameTextField.layer.masksToBounds = true
        usernameTextField.textColor = UIColor.black
        self.view.addSubview(usernameTextField)
        
        passwordTextField = UITextField(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.5, width: view.frame.width * 0.6, height: 50))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.placeholder = "  Password"
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = Constants.corner_radius
        passwordTextField.layer.masksToBounds = true
        passwordTextField.textColor = UIColor.black
        passwordTextField.isSecureTextEntry = true
        self.view.addSubview(passwordTextField)
    }
    
    func setupButtons() {
        signupButton = ColorButton(frame: CGRect(x: view.frame.width * 0.3, y: view.frame.height * 0.65, width: view.frame.width * 0.4, height: 50))
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setup()
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        self.view.addSubview(signupButton)
        
        goBackButton = ColorButton(frame: CGRect(x: view.frame.width * 0.3, y: view.frame.height * 0.75, width: view.frame.width * 0.4, height: 50))
        goBackButton.setTitle("<- Back", for: .normal)
        goBackButton.setup()
        goBackButton.addTarget(self, action: #selector(goBackButtonClicked), for: .touchUpInside)
        self.view.addSubview(goBackButton)
    }
    
    func signupButtonClicked() {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let name = nameTextField.text!
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error == nil {
                let ref = FIRDatabase.database().reference().child("Users").child((FIRAuth.auth()?.currentUser?.uid)!)
                ref.setValue(["name": name, "email": email])
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                self.nameTextField.text = ""
                self.performSegue(withIdentifier: "toFeedFromSignup", sender: self)
            }
            else {
                print(error.debugDescription)
        }
        })
    }
    
    func goBackButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}
