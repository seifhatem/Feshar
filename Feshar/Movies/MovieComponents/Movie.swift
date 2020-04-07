//
//  Movie.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/31/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation
struct Movie:Equatable{
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.title == rhs.title
    }
    
    var id: Int
    var title: String
    var posterIdentifier: String
    var genre: genre
    var duration: String
    var cast: [Cast]
    var imdbRating: String
    var tags: [Tag]
    var description: String
    var genreWithDuration: String{
        get{
            return genre.rawValue + " - " + duration
        }
    }
}
