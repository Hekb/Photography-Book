//
//  DatabaseManger.swift
//  Photography Book
//
//  Created by Hekmat on 5/1/20.
//  Copyright © 2020 Hekmat Barbar. All rights reserved.
//  The purpose of this class is to contain all of the database
//  functions in one package

import Foundation
import Firebase
import FirebaseFirestore

class DatabaseManger{
    //varaibeles
    static var shared = DatabaseManger()
    var currentUser:user?
    var events: [event] = []
    let db = Firestore.firestore()
    
    init(){
        currentUser = nil
    }
    
    func loadData(){
        db.collection("events").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let address = document.get("address") as! String
                    let date = document.get("date") as! String
                    let details = document.get("details") as! String
                    let host = document.get("host") as! String
                    let name = document.get("name") as! String
                    let time = document.get("time") as! String
                    let zipcode = document.get("zipcode") as! String
                    
                }
            }
        }

    }
    
    //function that creates a new user
    func createUser(newUser: user){
        guard let email = newUser.email else {return}
        guard let password = newUser.pass else {return}
        guard let fullname = newUser.fullname else {return}
        guard let username = newUser.userName else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            //If an error occurs
            if let er = error{
                print("Error occured while siging up: \(er.localizedDescription)")
                return
            }
            guard let userUID = result?.user.uid else{return}
            let data = ["email": email, "fullname": fullname, "username": username, "uid": userUID]
            self.db.collection("users").addDocument(data: data) { (error) in
                if let er = error {
                    print("error occured while inserting document")
                }
                print("New user addded")
            }
            /*
            guard let userUID = result?.user.uid else{return}
            let data = ["email": email, "username": username, "fullname": fullname]
            //Create a user
            Database.database().reference().child("users").child(userUID).updateChildValues(data) { (error, ref) in
                
                //If an error occurs
                if let er = error{
                    print("Error updating value while siging up: \(er.localizedDescription)")
                    return
                }
                //success
                print("New user addded")
                
            }
             */
            
        }
        
    }
    
    //function to sign in a user
    func singIn(email: String, password: String)->Bool{
        var successful = false
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if let er = error{
                print("Error while loggin: \(er.localizedDescription)")
                return
            }
            print(result?.user.email)
            print(result?.user.uid)
            successful = true
            print("Logged in Successfully")
        }
        return successful
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
        }catch let error {
            print("error while sign out: \(error.localizedDescription)")
        }
    }
    
    func isUserLogedIn() -> Bool{
        if Auth.auth().currentUser == nil{
            print("no user is logged in")
            return false
        }else{
            print("user is logged in")
            return true
        }
    }
    
    
}
