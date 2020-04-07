//
//  MoviesHelper.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/31/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation

//var watchList:  [Movie]   = UserDefaults.standard.object(forKey: "watchList") as? [Movie] ?? [Movie]()
private var watchList:  [Movie] = [Movie]()
//var staticList = [bigmommashouse,baywatch,hobbs,wolfofwallstreet,babydriver,faultstars]


func setupDummyWatchList(){
    //watchList.append(wolfofwallstreet)
    //watchList.append(bigmommashouse)
}


func addToWatchList(movie: Movie){
    if !(isInWatchList(movie)){
        watchList.append(movie)
    }
    //saveWatchList()
    
}

func removeFromWatchList(index: Int){
    watchList.remove(at: index)
    //saveWatchList()
}

func fetchWatchList()->[Movie]{
    return watchList
}


func removeFromWatchList(movie: Movie){
    if let index =  watchList.firstIndex(of: movie){
        watchList.remove(at:index)
    }
    
    //saveWatchList()
}




func isInWatchList(_ movie: Movie)->Bool{
    if watchList.contains(movie){
        return true
    }
    return false
}

func saveWatchList(){
    //TODO: we don't save to userdefaults because what's the point
    let encodedData = try! NSKeyedArchiver.archivedData(withRootObject: watchList, requiringSecureCoding: false)
    UserDefaults.standard.set(encodedData, forKey: "watchList")
    UserDefaults.standard.synchronize()
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


