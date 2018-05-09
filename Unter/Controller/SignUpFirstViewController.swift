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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar()
        continueButton.isEnabled = false
        continueButton.setTitle(formIncomplete, for: .normal)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // Create Test User
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue("Brandon", forKey: "firstname")
        newUser.setValue("Tran", forKey: "lastname")
        newUser.setValue("Australia", forKey: "country")
        newUser.setValue("brandon@brandon.com", forKey: "email")
        newUser.setValue(0400000000, forKey: "phoneNumber")
        newUser.setValue("admin", forKey: "password")
        
        do {
            try context.save()
            print("Object Saved")
            
        } catch {
            print("Failed saving")
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
        
    }
    
} // end SignUpP1ViewController

