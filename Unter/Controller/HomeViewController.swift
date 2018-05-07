//
//  HomeViewController.swift
//  Unter
//
//  Created by Brandon Tran on 23/4/18.
//  Copyright © 2018 Brandon Tran. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var unterLabel: UILabel!
    
    var users = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        usernameField.setBottomBorder(underlineColour: UIColor.white)
        passwordField.setBottomBorder(underlineColour: UIColor.white)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInButtonTapped(_ sender: Any) {
        if usernameField.text != "" && passwordField.text != "" {
            print("Hello WORLD")
            checkLoginDetails(email: usernameField.text!, password: passwordField.text!)
        }
    }

    
    func checkLoginDetails(email: String, password: String) {
        var userEmail = ""
        var userPassword = ""
        print("Checking Login Details")
        
        
        for user in users {
            
            userEmail = user.value(forKeyPath: "email") as! String
            userPassword = user.value(forKeyPath: "password") as! String
            print(userPassword)
            
            if email == userEmail && password == userPassword {
                performSegue(withIdentifier: "loginSuccessSegue", sender: self)
            }
            else {
                // error
            }
        }
    }
} // end class

