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
    var id: Int
    var photoIdentifier: String
    var photoData: Data?
    var bio: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case photoIdentifier = "profile_path"
    }
}
