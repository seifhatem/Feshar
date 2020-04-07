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
     @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moivePoster: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var genreAndDurationLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToWishListButton: UIButton!
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupNavigationBar()
        setupMoviePage()
        updateWatchListButton()
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
        movieNameLabel?.text = movie!.title
        genreAndDurationLabel?.text = movie!.genreWithDuration
        imdbLabel?.text = String(movie!.imdbRating)
        descriptionLabel?.text = movie!.description
    }
    
    func updateWatchListButton(){
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
        //return movie!.cast.count
        return 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CastCell", for: indexPath) as! CastTableViewCell
//        cell.bioLabel.text = movie!.cast[indexPath.row].bio
//        cell.nameLabel.text = movie!.cast[indexPath.row].name
//        cell.photo.image = UIImage(named: movie!.cast[indexPath.row].photoIdentifier)
        return cell
    }

    

}
