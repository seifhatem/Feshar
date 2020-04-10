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
        case name = "name"
        case imdbRating = "vote_average"
        case description = "overview"
        case posterIdentifier = "poster_path"
        case genres = "genre_ids"
        case firstAirDate = "first_air_date"
    }
    
    var id: Int
    var title: String?
    var name: String?
    var genres: [Int]
    var genresString: [String]?
    var posterIdentifier: String
    var firstAirDate: String?
    var isTvShow:Bool{
        if firstAirDate == nil{return false}else{return true}
    }
    var posterData: Data?
    var imdbRating: Double
    var description: String
    var genreWithDuration: String {
        return genresString?.joined(separator: "/") ?? ""
    }
}

extension Decodable {
  init(from: Any) throws {
    let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
    let decoder = JSONDecoder()
    self = try decoder.decode(Self.self, from: data)
  }
}


