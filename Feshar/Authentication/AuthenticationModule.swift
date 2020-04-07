//
//  AuthenticationModule.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/24/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation

func authenticate(username: String, password: String) -> Bool{
    if username.lowercased() == "robusta" && password == "Robusta.123" {return true}
    return false
}

func authenticateWithSavedCredentials() -> Bool{
        if let savedPassword = UserDefaults.standard.string(forKey: "userPassword"), let savedUserName = UserDefaults.standard.string(forKey: "userUsername"){
            if authenticate(username: savedUserName, password: savedPassword){return true}
            else{saveCredentialsToUD(username: "", password: "")}
         }
    return false
    }


func saveCredentialsToUD(username: String, password: String){
    if username == "" || password == ""{
        UserDefaults.standard.set(nil, forKey: "userPassword")
        UserDefaults.standard.set(nil, forKey: "userUsername")
    }
    else{
        UserDefaults.standard.set(password, forKey: "userPassword")
        UserDefaults.standard.set(username, forKey: "userUsername")
    }
    UserDefaults.standard.synchronize()
}
