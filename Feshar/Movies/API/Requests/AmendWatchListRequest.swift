//
//  AmendWatchListRequest.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 4/9/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation

struct AmendWatchListRequest: Codable{
    var media_type: String
    var media_id: Int
    var watchlist: Bool
}
