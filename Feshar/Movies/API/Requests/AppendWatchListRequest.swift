//
//  AppendWatchListRequest.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 4/9/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation

struct AppendWatchListRequest: Codable{
    var movie_id: Int
    var movie_watchlist: Bool
}
