//
//  RegisterViewController.swift
//  Photography Book
//
//  Created by Hekmat on 5/1/20.
//  Copyright © 2020 Hekmat Barbar. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


    @IBAction func registerClicked(_ sender: Any) {
        guard let firstname = firstnameField.text else {
            errorMessage.text = "Missing First Name field"
            return
        }
        guard let lastname = lastnameField.text else {
            errorMessage.text = "Missing Last Name field"
            return
        }
        guard let email = emailField.text else {
            errorMessage.text = "Missing Email field"
            return
        }
        guard let password = passwordField.text else {
            errorMessage.text = "Missing Password field"
            return
        }
        guard let username = usernameField.text else {
            errorMessage.text = "Missing Username field"
            return
        }
        
        let newUser: user = user(email: email, password: password, fullname: firstname + " " + lastname, userName: username)
        DatabaseManger.shared.createUser(newUser: newUser)
        
        navigateToHome()
        
    }
    
    func navigateToHome(){
        let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
    }
    
}
