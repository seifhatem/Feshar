//
//  Movie.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/31/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation
//struct Movie:Equatable{
//    static func == (lhs: Movie, rhs: Movie) -> Bool {
//        return lhs.title == rhs.title
//    }
//
//    var id: Int
//    var title: String
//    var posterIdentifier: String
//    var genre: genre
//    var duration: String
//    var cast: [Cast]
//    var imdbRating: String
//    var tags: [Tag]
//    var description: String
//    var genreWithDuration: String{
//        get{
//            return genre.rawValue + " - " + duration
//        }
//    }
//}

struct Movie:Equatable,Decodable{
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.title == rhs.title
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case imdbRating = "vote_average"
        case description = "overview"
        case posterIdentifier = "poster_path"
    }
    
    var id: Int
    var title: String
    var posterIdentifier: String
    var posterData: Data?
    var imdbRating: Double
    var description: String
    var genreWithDuration: String{
        get{
            return ""
        }
    }
}

extension Decodable {
  init(from: Any) throws {
    let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
    let decoder = JSONDecoder()
    self = try decoder.decode(Self.self, from: data)
  }
}


