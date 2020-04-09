//
//  WishListViewController.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/31/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import UIKit

class WishListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var watchList = [Movie]()
    
    override func viewWillAppear(_ animated: Bool) {
       
        fetchWatchList()
        //tableView.reloadData()
    }
    
    func fetchWatchList(){
        httpGETRequest(urlString: MoviesAPI.Endpoints.GetWatchListURL.stringValue) { (data, error) in
             if error != nil {self.popAlertWithMessage("Couldn't communicate with the server");return;}
            guard let data = data else{self.popAlertWithMessage("Couldn't communicate with the server");return;}
            self.watchList = try! JSONDecoder().decode(GetWatchListResponse.self, from: data).results
            DispatchQueue.main.async {self.tableView.reloadData()}
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
    }
    
    func setButtonAsClicked(_ button: UIButton){
        button.backgroundColor = UIColor.systemPink
        button.setTitleColor(UIColor.white, for: .normal)
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
    
    //Table & Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let MovieDetailsViewController = segue.destination as? MovieDetailsViewController,
            let index = tableView.indexPathForSelectedRow?.row
            else {
                return
        }
        MovieDetailsViewController.movie = watchList[index]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToMovieDetails", sender: nil)
        //refreshing the thread to work when the watchlist is a subview of the featured view
        CFRunLoopWakeUp(CFRunLoopGetCurrent())
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        cell.titleLabel.text = watchList[indexPath.row].title
        cell.genreLabel.text = watchList[indexPath.row].genreWithDuration
        cell.imdbLabel.text = String(watchList[indexPath.row].imdbRating)
        if let poster = watchList[indexPath.row].posterData{
            cell.posterImage.image = UIImage(data: poster)
          }
        
        return cell
    }
    
    func popAlertWithMessage(_ message: String){

        DispatchQueue.main.async {
        let alert = UIAlertController.init(title: "Login Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeFromWatchList(index: indexPath.row)
            fetchWatchList()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
