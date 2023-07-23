//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        TMDBClient.getRequestToken(completion: handleRequestTokenResponse(success:error:))
    }
    
    func handleRequestTokenResponse(success: Bool, error: Error?) {
        if success {
            print("request token: \(TMDBClient.Auth.requestToken)")
            DispatchQueue.main.async {
                TMDBClient.login(username: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: self.handleLoginResponse(success:error:))
            }
        }
    }
    
    
    func handleLoginResponse(success: Bool, error: Error?) {
        print("login response: \(TMDBClient.Auth.requestToken)")
        if success {
        DispatchQueue.main.async {
            TMDBClient.openSession(completion: self.handleSessionResponse(success:error:))
            }
        } else {
            print("login not successful")
            print(error ?? "error")
        }
    }
                   
    func handleSessionResponse(success: Bool, error: Error?) {
        print("handling session response")
        if success {
            print("session ID: \(TMDBClient.Auth.sessionId)")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
            }
        } else {
            print("session not successful")
            print(error ?? "error")
        }
        
    }
    
    @IBAction func loginViaWebsiteTapped() {
        performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
}
                                   
                                   
// pw: TbenaMcatD42B*
