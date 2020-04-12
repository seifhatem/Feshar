//
//  FeaturedViewController.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/31/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var categoryTags = ["Movies","TV Shows"]
    var featuredMoviesList = [Movie]()
    var featuredShowsList = [Movie]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 185.0
        tableView.separatorColor = UIColor.clear
        setupNavigationBar()

        fetchFeaturedTVsList {
            DispatchQueue.main.async {self.tableView.reloadData()}
        }
        fetchFeaturedMovieList {
            DispatchQueue.main.async {self.tableView.reloadData()}
        }
        
    }
    
    func fetchFeaturedMovieList(completion: ()->Void){
        httpGETRequest(urlString: MoviesAPI.Endpoints.DiscoverMoviesURL.urlString) { (data, error) in
                   guard let data = data else{return}
                   guard let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else{return}
                   guard let movies = jsonResponse["results"] as? NSArray else{return}
                   for movie in movies{
                       
                       if var r =  try? Movie(from: movie){
                           
                       httpGETRequest(urlString: MoviesAPI.Endpoints.FetchPosterImageURL.urlString + r.posterIdentifier) { (data, error) in
                           guard let data = data else{return}
                           r.posterData = data
                           r.genresString = [String]()
                           for genreId in r.genres{
                               
                               if let genreString = genreList[genreId]{
                                   r.genresString?.append(genreString)
                               }
                               
                           }
                           self.featuredMoviesList.append(r)
                             DispatchQueue.main.async {self.tableView.reloadData();}
                       }
                          
                       }
                      
                   }
               }
    }
    
 func fetchFeaturedTVsList(completion: ()->Void){
    httpGETRequest(urlString: MoviesAPI.Endpoints.DiscoverShowsURL.urlString) { (data, error) in
               guard let data = data else{return}
               guard let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else{return}
               guard let movies = jsonResponse["results"] as? NSArray else{return}
               for movie in movies{
                 if var r =  try? Movie(from: movie){
                   httpGETRequest(urlString: MoviesAPI.Endpoints.FetchPosterImageURL.urlString + r.posterIdentifier) { (data, error) in
                       guard let data = data else{return}
                       r.posterData = data
                       r.genresString = [String]()
                       for genreId in r.genres{
                           
                           if let genreString = genreList[genreId]{
                               r.genresString?.append(genreString)
                           }
                           
                       }
                       self.featuredShowsList.append(r)
                     DispatchQueue.main.async {self.tableView.reloadData()}
                   }
                 }
                      
                   
                   
               }
           }
    }
    
    
    //Custom Navigation Bar
     func setupNavigationBar(){
         let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
         imageView.contentMode = .scaleAspectFit
         let image = UIImage(named: "logo_port")
         imageView.image = image
         navigationItem.titleView = imageView
         navigationItem.leftBarButtonItem = UIBarButtonItem(customView: setupNavigationBackButton())
     }
     
     func setupNavigationBackButton()->UIButton{
         let backbutton = UIButton(type: .custom)
         backbutton.setTitle("←", for: .normal)
         backbutton.setTitleColor(backbutton.tintColor, for: .normal) // You can change the TitleColor
         backbutton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)

         return backbutton
         }
     
    @objc func backAction() -> Void {
         self.navigationController?.popViewController(animated: true)
     }
    
    
    
    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return categoryTags.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           if let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureCell", for: indexPath) as? FeaturedTableViewCell
       {
        if(cell.categoryLabel.text == "Movies"){
            cell.moviesList = featuredMoviesList
        }
        else
        {
           
            cell.moviesList = featuredShowsList
        }
           cell.categoryLabel.text = categoryTags[indexPath.row]
           cell.parentController = self
       return cell
       }
       return UITableViewCell()
       }
}
