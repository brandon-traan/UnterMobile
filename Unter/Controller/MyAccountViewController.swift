//
//  MyAccountViewController.swift
//  Unter
//
//  Created by Brandon Tran on 30/4/18.
//  Copyright © 2018 Brandon Tran. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myAccountTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.myAccountTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "nameCellIdentifier"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MyAccountTableViewCell else
        {
            return UITableViewCell()
        }
        
        cell.firstnameLabel.text = "John"
        cell.lastnameLabel.text = "Smith"
        cell.firstnameLabel.backgroundColor = .white
        return cell
    }

}
