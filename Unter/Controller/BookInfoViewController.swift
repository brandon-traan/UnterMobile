//
//  BookInfoViewController.swift
//  Unter
//
//  Created by Brandon Tran on 23/5/18.
//  Copyright © 2018 Brandon Tran. All rights reserved.
//

import UIKit

class BookInfoViewController: UIViewController {

    // MARK: UI Properties
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carMakeLabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var carYearLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var carImageViewAspectRatio: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func goBack(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
}
