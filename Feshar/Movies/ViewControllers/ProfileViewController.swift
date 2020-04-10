//
//  ProfileViewController.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 4/10/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        //TODO: Auto Login
        deleteSession();
        self.parent?.dismiss(animated: false, completion: nil)
    }
}
