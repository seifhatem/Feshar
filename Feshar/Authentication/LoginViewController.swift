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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginSpinnerView: UIView!
    
    override func viewDidLoad() {
        //self.view.bringSubviewToFront(loginSpinnerView)
        usernameTxtBox.text = "seifhatem"
        passwordTxtBox.text = "Robusta.123"
        super.viewDidLoad()
    }
    //Username and password should be required fields. If the user forgets to input either, a UIAlert should appear to warn them.
    //The password should be at least 8 characters long.  If the user inputs a password that is less than 8 characters, a UIAlert should appear to warn them.
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        //disable login form controls
        changeLoginFormStatus()
        loginSpinnerView.isHidden = false
        let decoder = JSONDecoder()
        if let enteredUsername  = usernameTxtBox.text, let enteredPassword = passwordTxtBox.text{
            if credentialsValidationCheck(username: enteredUsername, password: enteredPassword){
                //get request token
                httpGETRequest(urlString: MoviesAPI.Endpoints.CreateRquestTokenURL.urlString) { (data, error) in
                    
                    if error != nil {self.popAlertWithMessage("Couldn't communicate with the server");return;}
                    do {
                        let responseObject = try decoder.decode(CreateRequestTokenResponse.self, from: data!)
                        //create session with login
                        do{
                            let loginData = try JSONEncoder().encode(CreateSessionWithLoginRequest(username: enteredUsername, password: enteredPassword, request_token: responseObject.request_token))
                            
                            httpPOSTRequest(urlString: MoviesAPI.Endpoints.CreateSessionWithLoginURL.urlString, postData: loginData) { (data, error) in
                                 
                                if error != nil {self.popAlertWithMessage("Authentication Failed");return;}
                                let responseObject = try! decoder.decode(CreateSessionWithLoginResponse.self, from: data!)
                                if responseObject.success ?? false
                                {
                                    do{
                          let postData = try JSONEncoder().encode(CreateSessionRequest(request_token: responseObject.request_token!))
                                        httpPOSTRequest(urlString: MoviesAPI.Endpoints.CreateSessionURL.urlString, postData: postData) { (data, error) in
                                            if error != nil {self.popAlertWithMessage("Authentication Failed");return;}
                                        loginSession = try! decoder.decode(CreateSessionResponse.self, from: data!)
                                       //TODO: Implement Auto Login

                                            if loginSession?.success ?? false{
                                        DispatchQueue.main.async {self.showSuccessfulLoginVC(withUsername: enteredUsername)}
                                            self.self.fetchProfileData();
                                            }else{self.popAlertWithMessage("Could not create session");return;}
                                        }
                      }catch{self.popAlertWithMessage("Could not create session");return;}
                      
                  
                                }
                                else{
                                    self.popAlertWithMessage("Authentication Failed");return;
                                }
                                
                            }
                            
                        }
                        catch{self.popAlertWithMessage("Authentication Failed");return;}
                    }catch {self.popAlertWithMessage("Couldn't communicate with the server");return;}
                    
                }
            }
        }
    }
    
    func fetchProfileData(){
         httpGETRequest(urlString: MoviesAPI.Endpoints.ProfileURL.urlString) { (data, error) in
            
            LoggedInProfile = try! JSONDecoder().decode(Profile.self, from: data!)
            
        }
    }
    
    func changeLoginFormStatus(){
        if usernameTxtBox.isEnabled{
            usernameTxtBox.isEnabled = false
            passwordTxtBox.isEnabled = false
            loginButton.isEnabled = false
        }
        else{
            usernameTxtBox.isEnabled = true
            passwordTxtBox.isEnabled = true
            loginButton.isEnabled = true
        }
    }
    
    
    func popAlertWithMessage(_ message: String){
       
        DispatchQueue.main.async {
            
            //alert is called so the login process is definitely complete so reenable controls
             self.loginSpinnerView.isHidden = true
            self.changeLoginFormStatus()
            let alert = UIAlertController.init(title: "Login Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func credentialsValidationCheck(username: String, password: String) -> Bool{
        if username.count < 1 {popAlertWithMessage("a user name is required");return false;}
        if password.count < 1 {popAlertWithMessage("a password is required");return false;}
        if password.count < 8 {passwordTxtBox.text="";popAlertWithMessage("the password has to be at least 8 characters");return false;}
        return true
    }
    
    func showSuccessfulLoginVC(withUsername: String){
        
//        let successfulLoginVC = storyboard?.instantiateViewController(withIdentifier: "SuccessfulLoginViewController") as! SuccessfulLoginViewController
//
//        successfulLoginVC.modalPresentationStyle = .fullScreen
//        present(successfulLoginVC, animated: true, completion: nil)
//        successfulLoginVC.loggedinUserLabel.text = withUsername
        
        loginSpinnerView.isHidden = true
        usernameTxtBox.text = ""
        passwordTxtBox.text = ""
        let HomeVC = storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        
        HomeVC.modalPresentationStyle = .fullScreen
        present(HomeVC, animated: true, completion: nil)
        
    }
    
}
