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

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var unterLabel: UILabel!
    @IBOutlet weak var hidePasswordButton: UIButton!
    
    var loginButtonTitleEmpty = "Please Enter Your Email And Password"
    var loginButtonTitleIncorrect = "Incorrect Email or Password"
    var loginButtonTitleDefault = "Sign In"
    
    var users: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        emailField.setBottomBorder(underlineColour: UIColor.white)
        passwordField.setBottomBorder(underlineColour: UIColor.white)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }

    @IBAction func signInButtonTapped(_ sender: Any) {
        if emailField.text != "" && passwordField.text != "" {
            checkLoginDetails(email: emailField.text!, password: passwordField.text!)
        } else {
            loginButton.setTitle(loginButtonTitleEmpty, for: .normal)
        }
    }
    
    @IBAction func hidePassword(_ sender: Any) {
        if passwordField.isSecureTextEntry == true {
            passwordField.isSecureTextEntry = false
            hidePasswordButton.setImage(UIImage(named: "eyeIconOpen"), for: .normal)
        } else {
            passwordField.isSecureTextEntry = true
            hidePasswordButton.setImage(UIImage(named: "eyeIconClosed"), for: .normal)
        }
    }

    func checkLoginDetails(email: String, password: String) {
        var userEmail = ""
        var userPassword = ""
        var foundUser = true
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Users")
        
        // print("Checking Login Details: " + email + password)
        do {
            users = try managedContext.fetch(fetchRequest) as! [Users]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for user in users {
            userEmail = user.value(forKeyPath: "email") as! String
            userPassword = user.value(forKeyPath: "password") as! String
            
            if email.lowercased() == userEmail.lowercased() && password == userPassword {
                foundUser = true
                loginButton.setTitle(loginButtonTitleDefault, for: .normal)
            }
            else {
                foundUser = false
                loginButton.setTitle(loginButtonTitleIncorrect, for: .normal)
            }
        }
        
        if foundUser {
            performSegue(withIdentifier: "loginSuccessSegue", sender: self)
        }
    }
} // end class

