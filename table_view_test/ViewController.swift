//
//  ViewController.swift
//  table_view_test
//
//  Created by nine on 03/04/18.
//  Copyright © 2018 nine. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    //MARK : PROPERTIES
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self // setting viewcontroller as the nametextfield delegate
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keybooard
        textField.resignFirstResponder()
        return true
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    mealNameLabel.text = textField.text
    
    }
    //MARK: UIMAGE pickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //dimsiss the picker if the user selects cancel
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        //for selecting only original image
        guard  let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided following : \(info)")
        }
        
        //set pohotimageview to display the selected image.
        photoImageView.image = selectedImage
        
        //dimiss the picker
        dismiss(animated: true, completion: nil)
        
    }
    //MARK: ACTION
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //hide keyboard
               nameTextField.resignFirstResponder()
        
                let imagePickerController = UIImagePickerController()  //UIimage picker lets user pick media from their photo lib
               imagePickerController.sourceType = .photoLibrary  //only allows photos to be picked
            imagePickerController.delegate = self  //notifies  if the image has been picked
                present(imagePickerController, animated: true, completion: nil)
    }
}

