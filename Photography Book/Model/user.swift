//
//  user.swift
//  Photography Book
//
//  Created by Hekmat on 5/1/20.
//  Copyright © 2020 Hekmat Barbar. All rights reserved.
//

import Foundation

public class user{
    var email: String?
    var fullname: String?
    var pass:String?
    var userName: String?
    
    
    init(email: String, password: String, fullname: String, userName: String){
        self.email = email
        self.pass = password
        self.fullname = fullname
        self.userName = userName
    }

    
    
    
}
