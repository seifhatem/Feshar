////
////  ViewController.swift
////  Feshar
////
////  Created by Seif Elmenabawy on 3/23/20.
////  Copyright © 2020 Seif Elmenabawy. All rights reserved.
////
//
//import UIKit
//
//class AuthenticationViewController: UIViewController{
//    @IBOutlet weak var loginBtn: UIButton!
//    @IBOutlet weak var usernameTxtBox: UITextField!
//    @IBOutlet weak var passwordTxtBox: UITextField!
//    @IBOutlet weak var autoLoginSwitch: UISwitch!
//    @IBOutlet weak var logoutLabel: UILabel!
//    @IBOutlet weak var logoutLabel2: UILabel!
//    @IBOutlet weak var usernameLabel: UILabel!
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let VCId = self.restorationIdentifier
//        if((VCId?.contains("SuccessLogin")) ?? false){
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(logoutTapped))
//        gestureRecognizer.numberOfTapsRequired = 1
//        gestureRecognizer.numberOfTouchesRequired = 1
//        logoutLabel2?.isUserInteractionEnabled = true
//        logoutLabel?.isUserInteractionEnabled = true
//        logoutLabel2?.addGestureRecognizer(gestureRecognizer)
//        logoutLabel?.addGestureRecognizer(gestureRecognizer)
//        }
//        // Do any additional setup after loading the view.
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        
//        super.viewWillAppear(animated)
//        let VCId = self.restorationIdentifier
//         if VCId=="LoginViewController" {
//        passwordTxtBox.text = ""
//        usernameTxtBox.text = ""
//
//            if let savedPassword = UserDefaults.standard.string(forKey: "userPassword"), let savedUserName = UserDefaults.standard.string(forKey: "userUsername"){
//                 usernameTxtBox.text = savedUserName
//                 passwordTxtBox.text = savedPassword
//             }
//        }
//        
//         if VCId=="SuccessLoginPassedViewController" {
//            usernameLabel.text = UserDefaults.standard.string(forKey: "userUsername")
//        }
//        }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let VCId = self.restorationIdentifier
//                if VCId=="LoginViewController" {
//                if passwordTxtBox.text != "" &&  usernameTxtBox.text != ""{authenticateWithSavedCredentials()}
//        }
//           
//    }
//    
//    @IBAction func tryAgainPressed(_ sender: Any) {
//         dismiss(animated: true, completion:nil)
//    }
//    
//    
//    @IBAction func loginBtnPressed(_ sender: Any) {
//        if authenticate(){
//            if autoLoginSwitch.isOn{
//
//            }
//            
//            let SuccessLoginVC = storyboard?.instantiateViewController(withIdentifier: "SuccessLoginViewController")
//            SuccessLoginVC?.modalPresentationStyle = .fullScreen
//            present(SuccessLoginVC!, animated: true, completion: nil)
//
//
//        }
//        else
//        {
//            let FailedLoginVC = storyboard?.instantiateViewController(withIdentifier: "FailedLoginViewController")
//            present(FailedLoginVC!, animated: true, completion: nil)
//        }
//    }
//    
//    
//    func logout(){
//         UserDefaults.standard.set(nil, forKey: "userPassword")
//         UserDefaults.standard.set(nil, forKey: "userUsername")
//         dismiss(animated: true, completion:nil)
//        
//    }
//    
//    
//    @objc func logoutTapped(_ sender: UITapGestureRecognizer) {
//      logout()
//    }
//
//    
//    func authenticateWithSavedCredentials(){
//        if authenticate(){
//            let SuccessLoginVC = storyboard?.instantiateViewController(withIdentifier: "SuccessLoginPassedViewController")
//            SuccessLoginVC?.modalPresentationStyle = .fullScreen
//            present(SuccessLoginVC!, animated: true, completion: nil)
//        }
//    }
//    
//
//
//
//
//
//
//}
