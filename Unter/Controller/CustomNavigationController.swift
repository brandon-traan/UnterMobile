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
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UITextField {
    func setBottomBorder()
    {
        self.borderStyle = UITextBorderStyle.none;
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
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
}
