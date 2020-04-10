//
//  MoviesHelper.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/31/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation

var passedMovies = [Movie]()
var watchList:  [Movie] = [Movie]()
var genreList:  [Int:String] = [Int:String]()


func fetchWatchList(completion: @escaping () -> Void){
    httpGETRequest(urlString: MoviesAPI.Endpoints.GetWatchListURL.urlString) { (data, error) in
        if error != nil {return;}
        guard let data = data else{return;}
        watchList = try! JSONDecoder().decode(GetWatchListResponse.self, from: data).results
            for i in 0..<watchList.count{
                 watchList[i].genresString = [String]()
            for genreId in watchList[i].genres{
                if let genreString = genreList[genreId]{
                watchList[i].genresString?.append(genreString)
                }
            }
                httpGETRequest(urlString: MoviesAPI.Endpoints.FetchPosterImageURL.urlString + watchList[i].posterIdentifier) { (data, error) in
                    guard let data = data else{return}
                    watchList[i].posterData = data
                    completion()
                }
        }

        
    }
}








func addToWatchList(movie: Movie){
    let postData = try! JSONEncoder().encode(AppendWatchListRequest(movie_id: movie.id,movie_watchlist: true))
    httpPOSTRequest(urlString: MoviesAPI.Endpoints.AddToWachListURL.urlString, postData: postData){ (data, error) in
    }
    watchList.append(movie)
    
    }
    
func removeFromWatchList(index: Int){
    let postData = try! JSONEncoder().encode(AppendWatchListRequest(movie_id: watchList[index].id,movie_watchlist: false))
    watchList.remove(at: index)
    httpPOSTRequest(urlString: MoviesAPI.Endpoints.DeleteFromWatchListURL.urlString, postData: postData) { (data, error) in
    }
    
}

func isInWatchList(_ movie: Movie)->Bool{
    if watchList.contains(movie){
        return true
    }
    return false
}

func fetchGenreList(completion: @escaping()->Void){
    httpGETRequest(urlString: MoviesAPI.Endpoints.GetMovieGenreListURL.urlString) { (data, error) in
        if error != nil {return;}
        guard let data = data else{return;}
        let arrayOfGenres = (try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String, Any>)["genres"] as! [Dictionary<String, Any>]
      
        for genre in arrayOfGenres{
            if let key=genre["id"] as? Int,let value=genre["name"] as? String{
            genreList[key] = value
            }
        }
        completion()
    }
}



//func removeFromWatchList(movie: Movie){
//    if let index =  watchList.firstIndex(of: movie){
//        watchList.remove(at:index)
//    }
//}



//func getMoviesWithTag(tag: Tag)->[Movie]{
//    //    var returnList = [Movie]()
//    //    for movie in staticList{
//    //        if movie.tags.contains(tag){
//    //            returnList.append(movie)
//    //        }
//    //    }
//    //    return returnList
//    return [Movie]()
//}


