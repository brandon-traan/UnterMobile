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
    
    // MARK: NSManagedObject Variables
    var users: [NSManagedObject] = []
    // var vehicles: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        
        do {
            deleteExistingVehicles()
            createDummyVehicles()
        }
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
            loginButton.changeTitleTimer(loginButtonTitleEmpty, loginButtonTitleDefault)
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
    // MARK: Create Dummy Vehciles
    //
    func createDummyVehicles() {
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Vehicles", in: context)
        let vehicle = Vehicles(entity: entity!, insertInto: context)

        vehicle.make = "Toyota"
        vehicle.model = "Camry"
        vehicle.year = "2018"
        
        let location = Location(context: context)
        location.latitude = -37.805620
        location.longitude = 144.966143
        vehicle.location = location
        
        do {
            try context.save()
            print("Created Vehicle")
            
        } catch {
            print("Failed Creating Vehicle")
        }
    }
    
    //
    // MARK: Delete Data Records
    //
    func deleteExistingVehicles() -> Void {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Vehicles")
        let result = try? context.fetch(fetchRequest)
        let vehicles = result as! [Vehicles]
        
        for vehicle in vehicles {
            context.delete(vehicle)
        }
        
        do {
            try context.save()
            print("Deleted Vehicle!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            print("Failed Deleting Vehicle")
        }
    }

    //
    // MARK: Check Login Details with Device Database
    //
    func checkLoginDetails(email: String, password: String) {
        
        // Fetch User Database
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        do {
            users = try context.fetch(fetchRequest) as! [Users]
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
        loginButton.changeTitleTimer(loginButtonTitleIncorrect, loginButtonTitleDefault)
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
} // end class

