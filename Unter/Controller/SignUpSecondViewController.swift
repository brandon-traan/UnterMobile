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
import CoreData

class SignUpSecondViewController: UIViewController, UITextFieldDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: UI Properties
    @IBOutlet weak var attachmentLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    
    // MARK: Variables
    var avPlayerViewController: AVPlayerViewController!
    var image: UIImage?
    var lastChosenMediaType: String?
    let picker = UIImagePickerController()
    var noAttachment = "No File Attached"
    var hasAttachment = "Create Account"
    
    // MARK: Variables Passed from Previous View
    var firstname: String!
    var lastname: String!
    var email: String!
    var country: String!
    var password: String!
    var phoneNumber: Int!
    
    // Toast Message
    var toastMessage = "Account Created"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAccountButton.isEnabled = false
        createAccountButton.setTitle(noAttachment, for: .normal)
        attachmentLabel.isHidden = true
        
        // Delete user everytime this view is called
        do {
            deleteExistingUsers()
        }
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
        else
        {
            let alertController = UIAlertController(title: "Error accessing media", message: "Unsupported media source.",
                                                    preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    //
    // MARK: Popup Option Menu
    //
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
    
    //
    // MARK: Open Camera On Device
    //
    func openCamera() {
        if UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            pickMediaFromSource(UIImagePickerControllerSourceType.camera)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "No camera on device", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //
    // MARK: Open Gallery On Device
    //
    func openGallary() {
        pickMediaFromSource(UIImagePickerControllerSourceType.photoLibrary)
    }
    
    //
    // MARK: - UIImagePickerControllerDelegate
    //
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard (info[UIImagePickerControllerOriginalImage] as? UIImage) != nil else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        attachmentLabel.text = "Attached Successfully!"
        attachmentLabel.isHidden = false
        createAccountButton.isEnabled = true
        createAccountButton.setTitle(hasAttachment, for: .normal )
    }
    
    //
    // MARK: Execute Create User and Go Back to Login View
    //
    @IBAction func createAccount(_ sender: Any) {
        createUser()
        
        // Toast Style & Execution
        var style = ToastStyle()
        style.backgroundColor = .white
        style.messageColor = .orange
        self.navigationController!.view.window?.makeToast(toastMessage, duration: 2.0, position: .center, style: style)
        
        // Pop ViewController
        self.navigationController!.popToRootViewController(animated: true)
    }

    //
    // MARK: Create User Using Core Data
    //
    func createUser() -> Void {
        let context = getContext()

        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(firstname, forKey: "firstname")
        newUser.setValue(lastname, forKey: "lastname")
        newUser.setValue(country, forKey: "country")
        newUser.setValue(email, forKey: "email")
        newUser.setValue(phoneNumber, forKey: "phoneNumber")
        newUser.setValue(password, forKey: "password")
        
        do {
            try context.save()
            print("Save Created Object")
            
        } catch {
            print("Failed Saving Object")
        }
    }
    
    //
    // MARK: Delete Data Records
    //
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
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
