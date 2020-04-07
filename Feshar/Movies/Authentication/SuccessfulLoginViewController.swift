//
//  SuccessfulLoginViewController.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/24/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation
import UIKit

class SuccessfulLoginViewController: UIViewController{
    @IBOutlet weak var loggedinUserLabel: UILabel!
    
    @IBAction func logoutTapped(_ sender: Any) {
        saveCredentialsToUD(username: "", password: "")
        dismiss(animated: true, completion: nil)
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}
