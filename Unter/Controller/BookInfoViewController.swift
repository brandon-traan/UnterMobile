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
    
    // MARK: Variables
    var bookingMessage = "Successfully Booked"
    var bookingButtonTitle = "Unavailable"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func goBack(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func bookCar(_ sender: Any) {
        var totalTime = 1
        
        self.view.makeToastActivity(.center)
        
//        var style = ToastStyle()
//        style.backgroundColor = .white
//        style.messageColor = .orange
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
            if totalTime != 0 {
                totalTime -= 1
            } else {
                self.view.hideToastActivity()
                
                self.view.makeToast(self.bookingMessage, duration: 2.0, position: .center)
                self.bookButton.isEnabled = false
                self.bookButton.setTitle(self.bookingButtonTitle, for: .normal)
                
                t.invalidate()
            }
        })
    }
}
