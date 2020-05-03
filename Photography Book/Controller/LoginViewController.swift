//
//  LoginViewController.swift
//  Photography Book
//
//  Created by Hekmat on 5/1/20.
//  Copyright © 2020 Hekmat Barbar. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func loginClicked(_ sender: Any) {
        guard let email = emailField.text else{return}
        guard let pass = passwordField.text else {return}
        print(DatabaseManger.shared.singIn(email: email, password: pass))
        
        
        
        
    }

    
    func navigateToHome(){
        let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
    }


}
