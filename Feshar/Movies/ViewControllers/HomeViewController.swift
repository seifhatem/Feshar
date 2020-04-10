//
//  HomeViewController.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/31/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButtonsCollection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //var moviesList = fetchMoviesList()
    var moviesList = [Movie]()
    var filteredMovies: [Movie] = []
    
    var allButton: UIButton?
    var filterButtons = [UIButton]()
    var firstFilterButtonInitialized = false
    
    var filters = ["All"] + genre.allCases.map { $0.rawValue }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNavigationBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        
        filterButtonsCollection.delegate = self
        filterButtonsCollection.dataSource = self
        
        searchBar.delegate  = self
        searchBar.searchTextField.delegate = self
        searchBar.searchBarStyle = .minimal
        
        fetchMoviesList()
        fetchWatchList {}
    }
    
    func fetchMoviesList(){
        httpGETRequest(urlString: MoviesAPI.Endpoints.FetchMoviesListURL.urlString) { (data, error) in
            guard let data = data else{return}
            guard let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else{return}
            guard let movies = jsonResponse["results"] as? NSArray else{return}
            for movie in movies{
                var r =  try! Movie(from: movie)
                httpGETRequest(urlString: MoviesAPI.Endpoints.FetchPosterImageURL.urlString + r.posterIdentifier) { (data, error) in
                    guard let data = data else{return}
                    r.posterData = data
                    self.moviesList.append(r)
                    passedMovies = self.moviesList
                    self.filteredMovies = self.moviesList
                    DispatchQueue.main.async {self.tableView.reloadData()}
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
    
    
    // Filtering functions
    var isSearchBarEmpty: Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        setAllButtonsAsUnclickedExcept(allButton!)
        if isSearchBarEmpty {
            filteredMovies = moviesList
            tableView.reloadData()
        }
        else{
            print("hi")
            filterContentForSearchText(searchBar.text!)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredMovies = moviesList.filter { (movie: Movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func filterContentForGenre(_ genreText: String) {
        //        filteredMovies = moviesList.filter { (movie: Movie) -> Bool in
        //            return movie.genre.rawValue.lowercased().contains(genreText.lowercased())
        //        }
        filteredMovies = moviesList
        tableView.reloadData()
    }
    
    @objc func filterButtonTapped(_ sender: UIButton) {
        
        searchBar.text = ""
        searchBar.resignFirstResponder()
        if String(sender.title(for: .normal)!) == "All"{
            filteredMovies = moviesList
            tableView.reloadData()
        }
        else
        {
            filterContentForGenre(sender.title(for: .normal)!)
        }
        setAllButtonsAsUnclickedExcept(sender)
    }
    
    
    //Filter button UI Modifiers
    func setButtonAsClicked(_ button: UIButton){
        button.backgroundColor = UIColor.systemPink
        button.setTitleColor(UIColor.white, for: .normal)
    }
    
    func setAllButtonsAsUnclickedExcept(_ button: UIButton){
        for buttono in filterButtons{
            buttono.backgroundColor = UIColor.white
            buttono.setTitleColor(UIColor.black, for: .normal)
        }
        setButtonAsClicked(button)
    }
    
    
    func share(shareText:String?,shareImage:UIImage?){
        
        var objectsToShare = [Any]()
        
        if let shareImageObj = shareImage{
            objectsToShare.append(shareImageObj)
        }
        
        if let shareTextObj = shareText{
            objectsToShare.append(shareTextObj)
        }
        
        if shareText != nil || shareImage != nil{
            let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            present(activityViewController, animated: true, completion: nil)
        }else{
            print("There is nothing to share")
        }
    }
    
    //Tables & Segues
    
    //TableView Setup
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToMovieDetails2", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        //return 20
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        cell.titleLabel.text = filteredMovies[indexPath.section].title
        cell.genreLabel.text = filteredMovies[indexPath.section].genreWithDuration
        cell.imdbLabel.text = String(filteredMovies[indexPath.section].imdbRating)
        
        cell.descriptionLabel.text = filteredMovies[indexPath.section].description
        cell.bringSubviewToFront(cell.posterImage)
        
        if let data = self.filteredMovies[indexPath.section].posterData{
            cell.posterImage.image = UIImage(data: data)
        }
        else{
            
        }
        return cell
    }
    
    
    
    //CollectionView Setup
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterButtonCell", for: indexPath) as! FilterButtonCollectionViewCell
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(13)
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 38).isActive = true
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle(filters[indexPath.row], for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        
        
        cell.contentView.addSubview(button)
        
        filterButtons.append(button)
        if (indexPath.item == 0){ allButton = button}
        
        
        if !(firstFilterButtonInitialized){
            setButtonAsClicked(button)
            firstFilterButtonInitialized = true
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    
    //Add to watch list cell button
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let isAlreadyInList = isInWatchList(self.filteredMovies[indexPath.section])
        
        let watchListButton = UIContextualAction(style: .normal, title: "Add to watchlist") { (action, view, success) in
            if !(isAlreadyInList) {addToWatchList(movie: self.filteredMovies[indexPath.section])}
            else{
                let alert = UIAlertController.init(title: "Already in watchlist", message: "You've added it before", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            success(true)
        }
        watchListButton.image = UIImage(systemName: "star")
        var config = UISwipeActionsConfiguration(actions: [watchListButton])
        config = UISwipeActionsConfiguration(actions: [watchListButton])
        if !(isAlreadyInList) {watchListButton.backgroundColor = .green}
        
        return config
    }
    
    //Share cell button
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let shareButton = UIContextualAction(style: .normal,title: "Share") { (action, view, success) in
            let text = "I just stumbled upon this movie on Feshar, wanna watch it with me?\n\(self.filteredMovies[indexPath.section].title)\n\(self.filteredMovies[indexPath.section].genreWithDuration)\n\n\(self.filteredMovies[indexPath.section].description)"
            let imageToShare = UIImage(named: self.filteredMovies[indexPath.section].posterIdentifier)
            self.share(shareText: text, shareImage: imageToShare)
            success(true)
        }
        shareButton.image = UIImage(systemName: "square.and.arrow.up")
        shareButton.backgroundColor = .green
        
        
        let config = UISwipeActionsConfiguration(actions: [shareButton])
        return config
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let MovieDetailsViewController = segue.destination as? MovieDetailsViewController,
            let index = tableView.indexPathForSelectedRow?.section
            else {
                return
        }
        MovieDetailsViewController.movie = filteredMovies[index]
    }
}

