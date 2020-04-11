//
//  ProfileResponse.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 4/11/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation
var LoggedInProfile: Profile?

struct Profile: Codable{
    var name: String
    var username: String
    
    func getUserName()->String{
        if name.count>1{
            return name
        }
        if username.count>1{
            return username
        }
        return "User"
    }
}
