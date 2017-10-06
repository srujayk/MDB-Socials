//
//  NewSocialViewController.swift
//  MDBSocial
//
//  Created by Srujay Korlakunta on 9/26/17.
//  Copyright © 2017 Srujay Korlakunta. All rights reserved.
//
import UIKit
import Firebase

class NewSocialViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var eventDesc: UITextField!
    var eventName: UITextField!
    var eventDate: UITextField!
    let imagePicker = UIImagePickerController()
    var imageButton: UIButton!
    var imageView: UIImageView!
    var imageURL: String!
    var host: User!
    var createSocialButton: ColorButton!
    var cancelButton: ColorButton!
    var database: FIRDatabaseReference = FIRDatabase.database().reference()
    var storage: FIRStorageReference = FIRStorage.storage().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.mdb_blue
        imagePicker.delegate = self

        setupTextFields()
        setupImagePicker()
        setupButtons()
    }
    
    func setupTextFields() {
        eventName = UITextField(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.2, width: view.frame.width * 0.6, height: 50))
        eventName.adjustsFontSizeToFitWidth = true
        eventName.placeholder = "  Name of Event"
        eventName.layer.borderColor = UIColor.lightGray.cgColor
        eventName.layer.borderWidth = 1.0
        eventName.backgroundColor = .white
        eventName.layer.cornerRadius = Constants.corner_radius
        eventName.layer.masksToBounds = true
        eventName.textColor = UIColor.black
        view.addSubview(eventName)
        
        
        eventDate = UITextField(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.3, width: view.frame.width * 0.6, height: 50))
        eventDate.placeholder = "  Date of Event"
        eventDate.adjustsFontSizeToFitWidth = true
        eventDate.layer.borderColor = UIColor.lightGray.cgColor
        eventDate.layer.borderWidth = 1.0
        eventDate.backgroundColor = .white
        eventDate.layer.cornerRadius = Constants.corner_radius
        eventDate.layer.masksToBounds = true
        eventDate.textColor = UIColor.black
        view.addSubview(eventDate)
        
        
        eventDesc = UITextField(frame: CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.4, width: view.frame.width * 0.6, height: 50))
        eventDesc.placeholder = "  Enter Event Description"
        eventDesc.adjustsFontSizeToFitWidth = true
        eventDesc.layoutIfNeeded()
        eventDesc.layer.borderColor = UIColor.lightGray.cgColor
        eventDesc.layer.borderWidth = 1.0
        eventDesc.backgroundColor = .white
        eventDesc.layer.cornerRadius = Constants.corner_radius
        eventDesc.layer.masksToBounds = true
        eventDesc.textColor = UIColor.black
        view.addSubview(eventDesc)
    }
    
    // Image Picker Settings START
    func setupImagePicker() {
        imageView = UIImageView(frame: CGRect(x: view.frame.width * 0.3, y: view.frame.height * 0.5, width: view.frame.width * 0.4, height: 50))
        imageButton = UIButton(frame: imageView.frame)
        imageButton.setTitle("Pick Image", for: .normal)
        imageButton.setTitleColor(UIColor.blue, for: .normal)
        imageButton.layer.cornerRadius = Constants.corner_radius
        imageButton.backgroundColor = .white
        imageButton.setTitleColor(.black, for: .normal)
        imageButton.addTarget(self, action: #selector(loadImageButtonTapped), for: .touchUpInside)
        view.addSubview(imageView)
        view.addSubview(imageButton)
        view.bringSubview(toFront: imageButton)
    }
    
    func loadImageButtonTapped(sender: UIButton!) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageButton.removeFromSuperview()
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        dismiss(animated:true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    //Image Picker Settings END
    
    
    func setupButtons() {
        
        createSocialButton = ColorButton(frame: CGRect(x: view.frame.width * 0.3, y: view.frame.height * 0.65, width: view.frame.width * 0.4, height: 50))
        createSocialButton.setTitle("Add Social", for: .normal)
        createSocialButton.layoutIfNeeded()
        createSocialButton.setup()
        createSocialButton.addTarget(self, action: #selector(createSocial), for: .touchUpInside)
        view.addSubview(createSocialButton)
        
        cancelButton = ColorButton(frame: CGRect(x: view.frame.width * 0.3, y: view.frame.height * 0.75, width: view.frame.width * 0.4, height: 50))
        cancelButton.setTitle("<- Back", for: .normal)
        cancelButton.setup()
        cancelButton.addTarget(self, action: #selector(cancelEntry), for: .touchUpInside)
        view.addSubview(cancelButton)
    }
    
    
    func createSocial(sender: UIButton!) {
        storage = storage.child("profilepics/\((database.child("Posts").childByAutoId().key))")
        let profileImageData = UIImageJPEGRepresentation(imageView.image!, 0.9)
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"

        storage.put(profileImageData!, metadata: metadata).observe(.success) { (snapshot) in
            self.imageURL = snapshot.metadata?.downloadURL()?.absoluteString
            let newSocial = ["name": self.eventName.text!, "title": self.eventName.text!, "date": self.eventDate.text!, "text": self.eventDesc.text!, "poster": self.host?.name, "posterId": self.host?.id, "imageURL": self.imageURL] as [String : Any]

            self.pictureUploadHelper(id: self.database.child("Posts").childByAutoId().key) {
                let key = self.database.child("Posts").childByAutoId().key
                let childUpdates = ["/\(key)/": newSocial]
                self.database.child("Posts").updateChildValues(childUpdates)
            }
        }
        self.dismiss(animated: true, completion: nil)

    }

    func pictureUploadHelper(id: String, withBlock: @escaping () -> ()) {
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        storage.child("profilepics/\((id))").put(UIImageJPEGRepresentation(imageView.image!, 0.9)!, metadata: metadata).observe(.success) { (snapshot) in
            self.imageURL = snapshot.metadata?.downloadURL()?.absoluteString
            withBlock()
        }
    }
    
    func cancelEntry(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
