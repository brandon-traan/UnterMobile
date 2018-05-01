//
//  SignUpSecondViewController.swift
//  Unter
//
//  Created by Brandon Tran on 30/4/18.
//  Copyright © 2018 Brandon Tran. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MobileCoreServices

class SignUpSecondViewController: UIViewController, UITextFieldDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var attachmentLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    
    var avPlayerViewController: AVPlayerViewController!
    var image: UIImage?
    var lastChosenMediaType: String?
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // MARK: - CAMERA
    //
    func pickMediaFromSource(_ sourceType: UIImagePickerControllerSourceType)
    {
        // What media types are available on the device
        let mediaTypes = UIImagePickerController.availableMediaTypes(for: sourceType)!
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) && mediaTypes.count > 0
        {
            // Display the media types avaialble on the picker
            picker.mediaTypes = mediaTypes
            
            // Set delegate to self for system method calls.
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = sourceType
            
            // Present the picker to the user.
            
            present(picker, animated: true, completion: nil)
        }
            // Otherwise display an error message
        else
        {
            let alertController = UIAlertController(title: "Error accessing media", message: "Unsupported media source.",
                                                    preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func choosePhotoOption(_ sender: UIButton)
    {
        let alert = UIAlertController(title: "Select Photo From", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler:
            {
                _ in self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler:
            {
                _ in self.openGallary()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            pickMediaFromSource(UIImagePickerControllerSourceType.camera)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "No camera on device", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        pickMediaFromSource(UIImagePickerControllerSourceType.photoLibrary)
    }
    
    
    //
    // MARK: - UIImagePickerControllerDelegate
    //
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard (info[UIImagePickerControllerOriginalImage] as? UIImage) != nil else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        attachmentLabel.text = "Photo Attached"
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