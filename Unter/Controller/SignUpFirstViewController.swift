//
//  SignUpViewController.swift
//  Unter
//
//  Created by Brandon Tran on 23/4/18.
//  Copyright © 2018 Brandon Tran. All rights reserved.
//

import UIKit
import CoreData

class SignUpFirstViewController: UIViewController {

    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet var textFields: [UITextField]!
    
    var white = UIColor.white
    var red = UIColor.red
    
    var formIncomplete = "Form Incomplete"
    var formIsComplete = "Continue"
    
    
    var user = (firstName: "", lastName: "", country: "", email: "", phoneNumber: 0, password: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNavigationBar()
        continueButton.isEnabled = false
        continueButton.setTitle(formIncomplete, for: .normal)
        
        do {
            deleteExistingUsers()
            // createTestUser()
        }
        
        // Register View Controller as Observer
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: Notification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        firstnameTextField.setBottomBorder(underlineColour: white)
        lastnameTextField.setBottomBorder(underlineColour: white)
        countryTextField.setBottomBorder(underlineColour: white)
        emailTextField.setBottomBorder(underlineColour: white)
        phoneTextField.setBottomBorder(underlineColour: white)
        passwordTextField.setBottomBorder(underlineColour: white)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    // MARK: - Notification Handling
    
    @objc private func textDidChange(_ notification: Notification) {
        var formIsValid = true
        
        for textField in textFields {

            let valid = validate(textField)
            
            guard valid else {
                formIsValid = false
                break
            }
        }
        
        if formIsValid {
            continueButton.isEnabled = true
            continueButton.setTitle(formIsComplete, for: .normal)
        } else {
            continueButton.isEnabled = false
            continueButton.setTitle(formIncomplete, for: .normal)
        }
    }
    
    fileprivate func validate(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        return text.count > 0
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        // user = (firstnameTextField.text!, lastnameTextField.text!, countryTextField.text!, emailTextField.text!, // //phoneTextField.text!, passwordTextField.text!)
        user.firstName = firstnameTextField.text!
        user.lastName = lastnameTextField.text!
        user.country = countryTextField.text!
        user.email = emailTextField.text!
        user.phoneNumber = Int(phoneTextField.text!)!
        user.password = passwordTextField.text!
        
        performSegue(withIdentifier: "signUpP2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUpP2" {
            if let signP2Controller = segue.destination as? SignUpSecondViewController {
                signP2Controller.firstname = user.firstName
                signP2Controller.lastname = user.lastName
                signP2Controller.country = user.country
                signP2Controller.email = user.email
                signP2Controller.phoneNumber = user.phoneNumber
                signP2Controller.password = user.password
            }
        }
    }
    
    // MARK: Delete Data Records
    
    func deleteExistingUsers() -> Void {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        let result = try? context.fetch(fetchRequest)
        let users = result as! [Users]
        
        for user in users {
            context.delete(user)
        }
        
        do {
            try context.save()
            print("Save Deleted Object!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            print("Failed Deleting Object")
        }
        
    }
    
    func createTestUser() -> Void {
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue("Brandon", forKey: "firstname")
        newUser.setValue("Tran", forKey: "lastname")
        newUser.setValue("Australia", forKey: "country")
        newUser.setValue("admin", forKey: "email")
        newUser.setValue(0400000000, forKey: "phoneNumber")
        newUser.setValue("admin", forKey: "password")
        
        do {
            try context.save()
            print("Save Created Object")
            
        } catch {
            print("Failed Saving Object")
        }
    }
    
    // MARK: Get Context
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
} // end SignUpP1ViewController
