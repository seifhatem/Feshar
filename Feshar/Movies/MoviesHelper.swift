//
//  MoviesHelper.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/31/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation

var watchList:  [Movie] = [Movie]()
var genreList:  [Int:String] = [Int:String]()

func fetchWatchList(completion: @escaping () -> Void) {
    httpGETRequest(urlString: MoviesAPI.Endpoints.GetWatchListMoviesURL.urlString) { (data, error) in
        if error != nil {return;}
        guard let data = data else{return;}
        watchList = try! JSONDecoder().decode(GetWatchListResponse.self, from: data).results
        
        httpGETRequest(urlString: MoviesAPI.Endpoints.GetWatchListTVsURL.urlString) { (data, error) in
            if error != nil {return;}
            guard let data = data else{return;}
            let tvWatchList =  try! JSONDecoder().decode(GetWatchListResponse.self, from: data).results
            
            if(watchList.count == 0){completion()}
            
            watchList = watchList + tvWatchList
            addGenresToMoviesArray(movies: &watchList)
            
            addPosterImageToMoviesArray(movies: watchList){returnedMovies in
                watchList = returnedMovies
                completion()
            }
            
        }
    }
    
}


func addToWatchList(movie: Movie){
    let postData = try! JSONEncoder().encode(AmendWatchListRequest(media_type: movie.getTypeString, media_id: movie.id, watchlist: true))
    httpPOSTRequest(urlString: MoviesAPI.Endpoints.AmendWatchListURL.urlString, postData: postData){ (data, error) in
    }
    watchList.append(movie)
    
}

func removeFromWatchList(index: Int){
    let postData = try! JSONEncoder().encode(AmendWatchListRequest(media_type: watchList[index].getTypeString, media_id: watchList[index].id, watchlist: false))
    watchList.remove(at: index)
    httpPOSTRequest(urlString: MoviesAPI.Endpoints.AmendWatchListURL.urlString, postData: postData) { (data, error) in
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



func fetchMoviesList(completion: @escaping ([Movie]) -> ()){
    var returnedMovies = [Movie]()
    httpGETRequest(urlString: MoviesAPI.Endpoints.FetchMoviesListURL.urlString) { (data, error) in
        guard let data = data else{return}
        guard let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else{return}
        guard let movies = jsonResponse["results"] as? NSArray else{return}
        for movie in movies{
            let r =  try! Movie(from: movie)
            returnedMovies.append(r)
        }
        
        addGenresToMoviesArray(movies: &returnedMovies)
        
        addPosterImageToMoviesArray(movies: returnedMovies){returnedMovies in
            
            completion(returnedMovies)
        }
        
        
        
    }
}

func addPosterImageToMoviesArray(movies: [Movie],completion: @escaping (_ returnedMovies: [Movie]) -> ()){
    
    let moviesCount = movies.count
    var returnedMovies = [Movie]();
    var originalMovies = movies
    
    
    for i in 0..<moviesCount{
        
        httpGETRequest(urlString: MoviesAPI.Endpoints.FetchPosterImageURL.urlString + originalMovies[i].posterIdentifier) { (data, error) in
            guard let data = data else{return}
            
            originalMovies[i].posterData = data
            returnedMovies.append(originalMovies[i])
            if(moviesCount==returnedMovies.count){completion(returnedMovies)}
        }
    }
}

func addGenresToMoviesArray(movies: inout [Movie]){
    
    for i in 0..<movies.count{
        
        var movie = movies[i]
        movie.genresString = [String]()
        for genreId in movie.genres{
            if let genreString = genreList[genreId]{
                movie.genresString!.append(genreString)
            }
        }
        
        movies[i] = movie
        
    }
    
    
}
