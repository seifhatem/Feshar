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
    
    var categoryTags: [Tag] = [.New,.Trending,.Action,.Comedy,.Romance]
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 185.0
        tableView.separatorColor = UIColor.clear
        setupNavigationBar()
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
       //cell.categoryTag = categoryTags[indexPath.row]
       //cell.moviesList = getMoviesWithTag(tag: categoryTags[indexPath.row])
        cell.moviesList = passedMovies
           cell.categoryLabel.text = categoryTags[indexPath.row].rawValue.uppercased()
           cell.parentController = self
       return cell
       }
       return UITableViewCell()
       }
}
