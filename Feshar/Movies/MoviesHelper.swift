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


func fetchWatchList(completion: @escaping () -> Void){
    httpGETRequest(urlString: MoviesAPI.Endpoints.GetWatchListURL.stringValue) { (data, error) in
        if error != nil {return;}
        guard let data = data else{return;}
        watchList = try! JSONDecoder().decode(GetWatchListResponse.self, from: data).results
        fetcPostersForWatchList {
            completion()
        }
        
    }
}

func fetcPostersForWatchList(completion: @escaping () -> Void){
    for i in 0..<watchList.count{
    var movie = watchList[i]
    httpGETRequest(urlString: MoviesAPI.Endpoints.FetchPosterImageURL.stringValue + movie.posterIdentifier) { (data, error) in
        guard let data = data else{return}
        movie.posterData = data
        watchList[i] = movie
        completion()
    }
}
}

func addToWatchList(movie: Movie){
    let postData = try! JSONEncoder().encode(AppendWatchListRequest(movie_id: movie.id,movie_watchlist: true))
    httpPOSTRequest(urlString: MoviesAPI.Endpoints.AddToWachListURL.stringValue, postData: postData){ (data, error) in
    }
    watchList.append(movie)
    
    }
    


func removeFromWatchList(index: Int){
    let postData = try! JSONEncoder().encode(AppendWatchListRequest(movie_id: watchList[index].id,movie_watchlist: false))
    watchList.remove(at: index)
    httpPOSTRequest(urlString: MoviesAPI.Endpoints.DeleteFromWatchListURL.stringValue, postData: postData) { (data, error) in
    }
    
}

func removeFromWatchList(movie: Movie){
    if let index =  watchList.firstIndex(of: movie){
        watchList.remove(at:index)
    }
}

func isInWatchList(_ movie: Movie)->Bool{
    if watchList.contains(movie){
        return true
    }
    return false
}

func getMoviesWithTag(tag: Tag)->[Movie]{
    //    var returnList = [Movie]()
    //    for movie in staticList{
    //        if movie.tags.contains(tag){
    //            returnList.append(movie)
    //        }
    //    }
    //    return returnList
    return [Movie]()
}


