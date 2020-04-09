//
//  CreateSessionWithLoginRequest.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 4/9/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation

struct CreateSessionWithLoginRequest: Codable{
    var username: String
    var password: String
    var request_token: String
}
