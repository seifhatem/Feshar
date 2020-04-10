//
//  MoviesAPI.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 4/7/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation
fileprivate let API_KEY = "837a91247630f256e2090a53ce2c831b"
var loginSession: CreateSessionResponse?
var allowCellularAccess = false
var showAdultContent: Bool{
    UserDefaults.standard.bool(forKey: "adultContent")
}

class MoviesAPI{
    
    
    enum Endpoints{
        static let baseURL = "https://api.themoviedb.org/3/"
        static let postersBaseURL = "https://image.tmdb.org/t/p/w300/"
        
        
        case CreateRquestTokenURL
        case FetchMoviesListURL
        case FetchPosterImageURL
        case FetchPersonURL
        case CreateSessionWithLoginURL
        case CreateSessionURL
        case GetWatchListURL
        case DeleteFromWatchListURL
        case AddToWachListURL
        case GetMovieGenreListURL
        case SearchMoviesURL
        case DeleteSessionURL
        case DiscoverMoviesURL
        case DiscoverShowsURL

        var urlString: String {
            switch self {
            case .CreateRquestTokenURL: return Endpoints.baseURL + "authentication/token/new"
            case .FetchMoviesListURL: return Endpoints.baseURL + "trending/movie/week?page=1&include_adult=\(showAdultContent)"
            case .FetchPosterImageURL:  return Endpoints.postersBaseURL
            case .FetchPersonURL:    return Endpoints.baseURL + "person/"
            case .CreateSessionWithLoginURL: return Endpoints.baseURL + "authentication/token/validate_with_login"
            case .GetWatchListURL: return Endpoints.baseURL + "account/1/watchlist/movies?session_id="
            case .AddToWachListURL: return Endpoints.baseURL + "account/1/watchlist?session_id="
            case .CreateSessionURL: return Endpoints.baseURL + "authentication/session/new"
            case .DeleteFromWatchListURL: return Endpoints.baseURL + "account/1/movie_watchlist?session_id="
            case .GetMovieGenreListURL: return Endpoints.baseURL + "genre/movie/list"
            case .SearchMoviesURL: return Endpoints.baseURL + "search/movie?page=1&include_adult=\(showAdultContent)&query="
            case .DeleteSessionURL: return Endpoints.baseURL + "authentication/session"
            case .DiscoverMoviesURL: return Endpoints.baseURL + "discover/movie?include_adult=\(showAdultContent)&page=1"
            case .DiscoverShowsURL: return Endpoints.baseURL + "discover/tv?include_adult=\(showAdultContent)&page=1"
            }
        }
        
    }
}
func httpGETRequest( urlString: String, completion: @escaping ( _ responseData: Data?, _ error: Error?) -> Void){
    let urlStringWithKey = appendKeysToURL(urlString: urlString).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    
    
    
    let configuration = URLSessionConfiguration.default
    configuration.allowsCellularAccess = allowCellularAccess
    
    let backgroundSession = URLSession(configuration: configuration)
    
    if let urlStringWithKey=urlStringWithKey, let url = URL(string: urlStringWithKey){
    let task = backgroundSession.dataTask(with: url) {data, httpresponse, error in
        
        //print("HTTP request completed")
        if let error = error{
            print("HTTP Request Error: " + error.localizedDescription)
        }
        
        if let _ = data{
            
            
        } else{
            print("Returned data is nil")
        }
        //print("hi \(error!.localizedDescription)")
        
        completion(data,error)
        
    }
        task.resume()
    }
    else{
        completion(nil,nil)
    }
    
    
    //print("HTTP Request started")
    
}

func httpPOSTRequest(urlString: String, postData: Data, completion: @escaping ( _ responseData: Data?, _ error: Error?) -> Void){
  let urlStringWithKey = appendKeysToURL(urlString: urlString)
    
    let url = URL(string: urlStringWithKey)
    
    
    let configuration = URLSessionConfiguration.default
    configuration.allowsCellularAccess = allowCellularAccess
    let backgroundSession = URLSession(configuration: configuration)

    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = backgroundSession.dataTask(with: request) {data, httpresponse, error in
        
        //print("HTTP request completed")
        if let error = error{
           print("HTTP Request Error: " + error.localizedDescription)
        
        }
        
        if let _ = data{
            
            
        } else{
            print("Returned data is nil")
        }
        
        completion(data,error)
        
    }
    
    task.resume()
    //print("HTTP Request started")
    
}

func deleteSession(){
    let url = URL(string: appendKeysToURL(urlString: MoviesAPI.Endpoints.DeleteSessionURL.urlString))
       
       
       let configuration = URLSessionConfiguration.default
       configuration.allowsCellularAccess = allowCellularAccess
       let backgroundSession = URLSession(configuration: configuration)

       var request = URLRequest(url: url!)
       request.httpMethod = "DELETE"
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try! JSONEncoder().encode(LogoutRequest(session_id: loginSession!.session_id!))
        let task = backgroundSession.dataTask(with: request) {data, httpresponse, error in
            
            //print("HTTP request completed")
            if let error = error{
               print("HTTP Request Error: " + error.localizedDescription)
            }
            
            if let _ = data{
                
                
            } else{
                print("Returned data is nil")
            }
            
        }
        
        task.resume()
    }
    
func appendKeysToURL(urlString: String) -> String{
    var urlStringWithKey = ""
    
    if let session = loginSession?.session_id, urlString.contains("session_id") {
        urlStringWithKey = urlString + session
    }
    else
    {
        urlStringWithKey = urlString
    }
    
    
    if (urlStringWithKey.contains("?")){
        urlStringWithKey = urlStringWithKey + "&api_key=" + API_KEY
    }
    else
    {
        urlStringWithKey = urlStringWithKey + "?api_key=" + API_KEY
    }
    return urlStringWithKey
}
