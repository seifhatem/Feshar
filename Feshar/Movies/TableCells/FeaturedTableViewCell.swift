//
//  FeaturedTableViewCell.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 4/1/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import UIKit

class FeaturedTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var categoryTag : Tag?
    var moviesList = [Movie]()
    var parentController: UIViewController?
    
    override func awakeFromNib() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        super.awakeFromNib()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let movieVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        movieVC.movie = moviesList[Int(tappedImage.accessibilityIdentifier!)!]
        parentController!.present(movieVC, animated: true, completion: nil)
    }
    
    //Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionCell", for: indexPath) as! FeaturedCollectionViewCell
        //cell.movieImage.image = UIImage(named: moviesList[indexPath.row].posterIdentifier)
        if let posterData =  moviesList[indexPath.row].posterData{
        cell.movieImage.image = UIImage(data: posterData)
        }
        cell.movieImage.accessibilityIdentifier = String(indexPath.row)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cell.movieImage.addGestureRecognizer(tapGestureRecognizer)
        
        return cell
    }
    
    
}
