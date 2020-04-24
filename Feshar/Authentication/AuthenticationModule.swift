//
//  AuthenticationModule.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/24/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation

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
