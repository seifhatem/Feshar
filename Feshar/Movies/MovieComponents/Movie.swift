//
//  Movie.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/31/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation
struct Movie:Equatable,Decodable{
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
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
    var getTypeString: String{
        if isTvShow{
            return "tv"
        }
        return "movie"
    }
    
    func getTitle()->String{
        if let title=title{
            return title
        }
        return name!
    }
}

extension Decodable {
  init(from: Any) throws {
    let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
    let decoder = JSONDecoder()
    self = try decoder.decode(Self.self, from: data)
  }
}


