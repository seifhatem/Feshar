//
//  Cast.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/30/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation

struct Cast: Decodable{
    var name: String
    var photoIdentifier: String
    var photoData: Data?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case photoIdentifier = "profile_path"
    }
}
