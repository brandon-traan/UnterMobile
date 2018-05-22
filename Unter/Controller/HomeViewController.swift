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

    // MARK: UI Properties
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var unterLabel: UILabel!
    @IBOutlet weak var hidePasswordButton: UIButton!
    
    // MARK: Variables
    var userEmail: String!
    var userPassword: String!
    var loginButtonTitleEmpty = "Empty Email or Password"
    var loginButtonTitleIncorrect = "Incorrect Email or Password"
    var loginButtonTitleDefault = "Sign In"
    var users: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        loginButton.setTitle(loginButtonTitleDefault, for: .normal)
        emailField.text = ""
        passwordField.text = ""
        hidePasswordButton.setImage(UIImage(named: "eyeIconClosed"), for: .normal)
        passwordField.isSecureTextEntry = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        emailField.setBottomBorder(underlineColour: UIColor.white)
        passwordField.setBottomBorder(underlineColour: UIColor.white)
    }

    //
    // MARK: Check Textfields
    //
    @IBAction func signInButtonTapped(_ sender: Any) {
        if emailField.text != "" && passwordField.text != "" {
            checkLoginDetails(email: emailField.text!, password: passwordField.text!)
        } else {
            loginButton.displayToastMessage(loginButtonTitleEmpty, loginButtonTitleDefault)
        }
    }
    
    //
    // MARK: Togglable Hide Password
    //
    @IBAction func hidePassword(_ sender: Any) {
        if passwordField.isSecureTextEntry == true {
            passwordField.isSecureTextEntry = false
            hidePasswordButton.setImage(UIImage(named: "eyeIconOpen"), for: .normal)
        } else {
            passwordField.isSecureTextEntry = true
            hidePasswordButton.setImage(UIImage(named: "eyeIconClosed"), for: .normal)
        }
    }

    //
    // MARK: Check Login Details with Device Database
    //
    func checkLoginDetails(email: String, password: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // Fetch User Database
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        do {
            users = try managedContext.fetch(fetchRequest) as! [Users]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        // Match Login with User's Details
        for user in users {
            userEmail = user.value(forKeyPath: "email") as! String
            userPassword = user.value(forKeyPath: "password") as! String
            if email.lowercased() == userEmail.lowercased() && password == userPassword
            {
                login(foundUser: true)
            }
        }
        login(foundUser: false)
    }
    
    //
    // MARK: Login if Details are Correct
    //
    func login(foundUser: Bool) {
        if foundUser {
            performSegue(withIdentifier: "loginSuccessSegue", sender: self)
        }
        loginButton.displayToastMessage(loginButtonTitleIncorrect, loginButtonTitleDefault)
    }
} // end class

