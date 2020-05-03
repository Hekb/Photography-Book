//
//  MainViewController.swift
//  Photography Book
//
//  Created by Hekmat on 5/2/20.
//  Copyright © 2020 Hekmat Barbar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
        self.navigationController!.pushViewController(VC1, animated: true)
        print(23)
    }
    


}
