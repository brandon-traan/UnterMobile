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
    
    @IBOutlet weak var myAccountTableView: UITableView!
    
    var users : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.myAccountTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        guard let cell = myAccountTableView.dequeueReusableCell(withIdentifier: "nameCellIdentifier", for: indexPath) as? MyAccountTableViewCell else
        {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            guard let cell = myAccountTableView.dequeueReusableCell(withIdentifier: "nameCellIdentifier", for: indexPath) as? MyAccountTableViewCell else
            {
                return UITableViewCell()
            }
            cell.firstnameLabel.text = user.value(forKeyPath: "firstname") as? String
            cell.lastnameLabel.text = user.value(forKeyPath: "lastname") as? String
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
            // TODO : FIX THIS
            let phoneNumber = String(describing: user.value(forKey: "phoneNumber"))
            cell.phoneNumberLabel.text = phoneNumber as String
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

    @IBAction func logout(_ sender: Any) {
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: {
                self.navigationController!.popToRootViewController(animated: true)
            })
        }
        else {
            self.navigationController!.popToRootViewController(animated: true)
        }
    }
}
