//
//  LoginViewController.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/24/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController{
    @IBOutlet weak var usernameTxtBox: UITextField!
    @IBOutlet weak var passwordTxtBox: UITextField!
    @IBOutlet weak var autoLoginSwitch: UISwitch!
    
    override func viewDidLoad() {
           super.viewDidLoad()
    }
    //Username and password should be required fields. If the user forgets to input either, a UIAlert should appear to warn them.
    //The password should be at least 8 characters long.  If the user inputs a password that is less than 8 characters, a UIAlert should appear to warn them.
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        if let enteredUsername  = usernameTxtBox.text, let enteredPassword = passwordTxtBox.text{
            if credentialsValidationCheck(username: enteredUsername, password: enteredPassword){
                if authenticate(username: enteredUsername ,password: enteredPassword){
                    if(autoLoginSwitch.isOn){saveCredentialsToUD(username: enteredUsername, password: enteredPassword)}
                    showSuccessfulLoginVC(withUsername: enteredUsername)
                }
                else{
                    popAlertWithMessage("Invalid email or password")
                }
            }
        }
    }
    
    
    func popAlertWithMessage(_ message: String){
        let alert = UIAlertController.init(title: "Login Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func credentialsValidationCheck(username: String, password: String) -> Bool{
        if username.count < 1 {popAlertWithMessage("a user name is required");return false;}
        if password.count < 1 {popAlertWithMessage("a password is required");return false;}
        if password.count < 8 {passwordTxtBox.text="";popAlertWithMessage("the password has to be at least 8 characters");return false;}
        return true
    }
    
    func showSuccessfulLoginVC(withUsername: String){
       let successfulLoginVC = storyboard?.instantiateViewController(withIdentifier: "SuccessfulLoginViewController") as! SuccessfulLoginViewController
       
        successfulLoginVC.modalPresentationStyle = .fullScreen
        present(successfulLoginVC, animated: true, completion: nil)
        successfulLoginVC.loggedinUserLabel.text = withUsername
    }
    
    func showFailedLoginVC(){
       passwordTxtBox.text = ""
       let failedLoginVC = storyboard?.instantiateViewController(withIdentifier: "FailedLoginViewController")
        present(failedLoginVC!, animated: true, completion: nil)
    }
    
}
