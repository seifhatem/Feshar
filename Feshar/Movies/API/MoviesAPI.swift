//
//  MoviesAPI.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 4/7/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation

let baseURL = "https://api.themoviedb.org/"
let postersBaseURL = "https://image.tmdb.org/t/p/w300/"

func httpGETRequest(urlString: String, completion: @escaping ( _ responseData: Data?, _ error: Error?) -> Void){
    
    let url = URL(string: urlString)
    
    
    let configuration = URLSessionConfiguration.default
    configuration.allowsCellularAccess = false
    
     let backgroundSession = URLSession(configuration: configuration)
     
 
     let task = backgroundSession.dataTask(with: url!) {data, httpresponse, error in
         
         print("HTTP request completed")
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
     print("HTTP Request started")

}
