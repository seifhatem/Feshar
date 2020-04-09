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
        
        
        var stringValue: String {
            switch self {
            case .CreateRquestTokenURL: return Endpoints.baseURL + "authentication/token/new"
            case .FetchMoviesListURL: return Endpoints.baseURL + "trending/movie/week?page=1&sort_by=release_date.desc"
            case .FetchPosterImageURL:  return Endpoints.postersBaseURL
            case .FetchPersonURL:    return Endpoints.baseURL + "person/"
            case .CreateSessionWithLoginURL: return Endpoints.baseURL + "authentication/token/validate_with_login"
            case .GetWatchListURL: return Endpoints.baseURL + "account/1/watchlist/movies?session_id="
            case .CreateSessionURL: return Endpoints.baseURL + "authentication/session/new"
                
            }
        }
        
    }
    
    //        func createRequestToken() -> CreateRequestTokenResponse?{
    //            var data = httpGETRequest(urlString: Endpoints.CreateRquestTokenURL.stringValue) { (responseData, error) in
    //                if error != nil {
    //                    return nil
    //                }
    //
    //                guard let responseData = responseData else{return nil}
    //                return responseData
    //            }
    //
    //            let decoder = JSONDecoder()
    //            do {
    //                let responseObject = try decoder.decode(CreateRequestTokenResponse.self, from: data)
    //                return responseObject
    //            } catch {
    //               return nil
    //            }
    //
    //
    //        }
}
func httpGETRequest( urlString: String, completion: @escaping ( _ responseData: Data?, _ error: Error?) -> Void){
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
    
    let url = URL(string: urlStringWithKey)
    
    
    let configuration = URLSessionConfiguration.default
    configuration.allowsCellularAccess = false
    
    let backgroundSession = URLSession(configuration: configuration)
    
    
    let task = backgroundSession.dataTask(with: url!) {data, httpresponse, error in
        
        //print("HTTP request completed")
        if let error = error{
            print("HTTP Request Error: " + error.localizedDescription)
        }
        
        if let _ = data{
            
            
        } else{
            print("Returned data is nil")
            return
        }
        
        completion(data,error)
        
    }
    
    task.resume()
    //print("HTTP Request started")
    
}

func httpPOSTRequest(urlString: String, postData: Data, completion: @escaping ( _ responseData: Data?, _ error: Error?) -> Void){
    var urlStringWithKey = ""
    
    if (urlString.contains("?")){
        urlStringWithKey = urlString + "&api_key=" + API_KEY
    }
    else
    {
        urlStringWithKey = urlString + "?api_key=" + API_KEY
    }
    
    let url = URL(string: urlStringWithKey)
    
    
    let configuration = URLSessionConfiguration.default
    configuration.allowsCellularAccess = false
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
            return
        }
        
        completion(data,error)
        
    }
    
    task.resume()
    //print("HTTP Request started")
    
}
