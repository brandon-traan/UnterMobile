//
//  CustomNavigationController.swift
//  Unter
//
//  Created by Brandon Tran on 27/4/18.
//  Copyright © 2018 Brandon Tran. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        
        self.hideKeyboardWhenTappedAround()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
}

extension UITextField {
    func setBottomBorder(underlineColour: UIColor)
    {
        self.borderStyle = UITextBorderStyle.none;
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = underlineColour.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        self.textColor = UIColor.white
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
    }
    
    func textFieldIsEmpty() -> Bool {
        if self.text?.isEmpty ?? true {
            return true
        }
        return false
    }
}

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    func displayToastMessage(_ message : String, _ defaultMessage: String) {
        var totalTime = 1
        
        self.setTitle(message, for: .normal)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
            if totalTime != 0 {
                totalTime -= 1
            } else {
                self.setTitle(defaultMessage, for: .normal)
                t.invalidate()
            }
        })
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideNavigationBar(){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func showNavigationBar() {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}



