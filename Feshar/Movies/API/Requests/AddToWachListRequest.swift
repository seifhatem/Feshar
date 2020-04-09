//
//  AddToWachListRequest.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 4/9/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation

struct AddToWachListRequest: Codable{
    let media_type = "movie"
    var media_id: Int
    let watchlist = true
}
