//
//  ProfileViewController.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 4/10/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adultContentSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adultContentSwitch.isOn = showAdultContent
        nameLabel.text = LoggedInProfile?.getUserName()
        // Do any additional setup after loading the view.
    }
   
    @IBAction func adultContentSwitched(_ sender: Any) {
        UserDefaults.standard.set((sender as! UISwitch).isOn ? true:false, forKey: "adultContent")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        //TODO: Auto Login
        deleteSession();
        self.parent?.dismiss(animated: false, completion: nil)
    }
}
