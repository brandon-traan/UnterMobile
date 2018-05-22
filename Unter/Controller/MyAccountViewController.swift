//
//  MyAccountViewController.swift
//  Unter
//
//  Created by Brandon Tran on 30/4/18.
//  Copyright © 2018 Brandon Tran. All rights reserved.
//

import UIKit
import CoreData

class MyAccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UI Properties
    @IBOutlet weak var accountBGIV: UIImageView!
    @IBOutlet weak var myAccountTableView: UITableView!
    
    // MARK: Variables
    var users : [NSManagedObject] = []
    
    // MARK: Toast Message
    var logoutMessage = "Logout Successful"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Fetch User Database
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        
        do {
            users = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //
    // MARK: Number of Table Rows Per Section
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    //
    // MARK: Populate Table Rows According to Row Number
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = users[0]
        
        guard let cell = myAccountTableView.dequeueReusableCell(withIdentifier: "nameCellIdentifier", for: indexPath) as? MyAccountTableViewCell else
        {
            return UITableViewCell()
        }
        
        //
        // TODO: Replace if statements with Switch
        //
        if indexPath.row == 0 {
            guard let cell = myAccountTableView.dequeueReusableCell(withIdentifier: "nameCellIdentifier", for: indexPath) as? MyAccountTableViewCell else
            {
                return UITableViewCell()
            }
            let firstname = user.value(forKeyPath: "firstname") as? String
            let lastname = user.value(forKeyPath: "lastname") as? String
            
            cell.firstnameLabel.text = firstname! + " " + lastname!
            return cell
        }

        if indexPath.row == 1 {
            guard let cell = myAccountTableView.dequeueReusableCell(withIdentifier: "emailCellIdentifier", for: indexPath) as? MyAccountTableViewCell else
            {
                return UITableViewCell()
            }
            cell.emailLabel.text = user.value(forKey: "email") as? String
            return cell
        }
        
        if indexPath.row == 2 {
            guard let cell = myAccountTableView.dequeueReusableCell(withIdentifier: "phoneCellIdentifier", for: indexPath) as? MyAccountTableViewCell else
            {
                return UITableViewCell()
            }
            let phoneNumber = user.value(forKey: "phoneNumber") as! Int64
            cell.phoneNumberLabel.text = "0" + String(phoneNumber)
            return cell
        }
        
        if indexPath.row == 3 {
            guard let cell = myAccountTableView.dequeueReusableCell(withIdentifier: "countryCellIdentifier", for: indexPath) as? MyAccountTableViewCell else
            {
                return UITableViewCell()
            }
            cell.countryLabel.text = user.value(forKey: "country") as? String
            return cell
        }
        return cell
    }
    
    //
    // MARK: Edit Account
    //
    @IBAction func editAccount(_ sender: Any) {
        // Edit Account
    }
    
    //
    // MARK: Go Back To Login View When Pressed
    //
    @IBAction func logout(_ sender: Any) {
        if self.presentingViewController != nil {
            
            // Toast Style & Execution
            var style = ToastStyle()
            style.backgroundColor = .white
            style.messageColor = .orange
            
            self.navigationController!.view.window?.makeToast(logoutMessage, duration: 2.0, position: .center, style: style)
            
            self.dismiss(animated: false, completion: {
                self.navigationController!.popToRootViewController(animated: true)
            })
        }
        self.navigationController!.popToRootViewController(animated: true)
    }
}
