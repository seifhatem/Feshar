//
//  MovieDetails.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/29/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var moivePoster: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var genreAndDurationLabel: UILabel!
    @IBOutlet private weak var imdbLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var addToWishListButton: UIButton!
    
    var movie: Movie?
    var castArray = [Cast]()
    var isTvShow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupNavigationBar()
        fetchCast()
        setupMoviePage()
        updateWatchListButton()
    }
    
    
    func fetchCast(){
        httpGETRequest(urlString: MoviesAPI.Endpoints.baseURL+"movie/"+String(movie!.id)+"/credits") { (data, error) in
            guard let data = data else{return}
            guard let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else{return}
            guard let cast = jsonResponse["cast"] as? NSArray else{return}
            for character in cast{
                guard var r =  try? Cast(from: character) else{return}
                httpGETRequest(urlString: MoviesAPI.Endpoints.postersBaseURL+r.photoIdentifier) { (data, error) in
                    guard let data = data else{return}
                    r.photoData = data
                    httpGETRequest(urlString: MoviesAPI.Endpoints.FetchPersonURL.urlString + String(r.id) ) { (data, error) in
                        guard let data = data else{return}
                        guard let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else{return}
                        guard let bio = jsonResponse["biography"] as? String else{return}
                        r.bio = bio
                        self.castArray.append(r)
                        DispatchQueue.main.async {self.tableView.reloadData()}
                    }
                }
            }
        }
    }
    
    
    func setupNavigationBar(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo_port")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    func setupMoviePage(){
        if let poster = movie!.posterData{
            moivePoster?.image = UIImage(data: poster)
        }
        if let title = movie!.title{
            movieNameLabel?.text = title
        }
        else
        {
               movieNameLabel?.text = movie!.name
            isTvShow = true
           
        }
        genreAndDurationLabel?.text = movie!.genreWithDuration
        imdbLabel?.text = String(movie!.imdbRating)
        descriptionLabel?.text = movie!.description
    }
    
    func updateWatchListButton(){
//        if isTvShow{
//            addToWishListButton.isEnabled = false
//            addToWishListButton.backgroundColor = .darkGray
//             addToWishListButton.setTitle("Movies Only", for: .disabled)
//            return;
//        }
        if (isInWatchList(movie!)){
            addToWishListButton.isEnabled = false
            addToWishListButton.backgroundColor = .darkGray
            addToWishListButton.setTitle("Already in watch list", for: .disabled)
        }
    }
    
    @IBAction func addToWatchlistTapped(_ sender: Any) {
        addToWatchList(movie: movie!)
        updateWatchListButton()
    }
    
    //Table Setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CastCell", for: indexPath) as! CastTableViewCell
        cell.bioLabel.text = castArray[indexPath.row].bio
        cell.nameLabel.text = castArray[indexPath.row].name
        
        if cell.bioLabel.text == ""{
        cell.addConstraint(NSLayoutConstraint(item: cell.contentView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: cell.photo, attribute: .height, multiplier: 1, constant: 20))
            cell.addConstraint(NSLayoutConstraint(item: cell.photo as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 45))
            cell.addConstraint(NSLayoutConstraint(item: cell.photo as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 45))
        }
        
        if let data =  self.castArray[indexPath.row].photoData{
            cell.photo.image = UIImage(data: data)
        }
        else{
            cell.photo.image = UIImage(named: "logo_port")
        }
        return cell
    }
    
    
    
}
