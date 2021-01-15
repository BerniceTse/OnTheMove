//
//  EditViewController.swift
//  CSIA
//
//  Created by Bernice Tse on 17/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class EditViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    var name = ""
    
    
    @IBOutlet weak var roomTextField: UITextField!
    @IBOutlet weak var roomLabel: UILabel!
    var room = ""
    var roomPickerView = UIPickerView()
    
    @IBOutlet weak var boxLabel: UILabel!
    @IBOutlet weak var boxTextField: UITextField!
    var box = ""
    var boxPickerView = UIPickerView()
    
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    var quantity = ""
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextField!
    var d = ""
    
    let rooms = ["Bathroom", "Bedroom", "Dining Room", "Kitchen", "Living Room", "Other"]
    let boxes = ["Tray", "Cupboard", "Shelf", "Drawer"]
    
    var bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //set up picker views
        roomPickerView.delegate = self
        roomPickerView.dataSource = self
        boxPickerView.delegate = self
        boxPickerView.dataSource = self
        
        //set textfield input as picker view
        roomTextField.inputView = roomPickerView
        boxTextField.inputView = boxPickerView
      
        //set up item name components
        nameTextField.delegate = self
        nameTextField.isHidden = true
        nameLabel.text = name
        nameLabel.isUserInteractionEnabled = true
        let nameTapGesture = UITapGestureRecognizer(target: self, action: #selector(EditViewController.namelabelTapped))
        nameTapGesture.numberOfTouchesRequired = 1
        nameLabel.addGestureRecognizer(nameTapGesture)
        
        //set up room name components
        roomTextField.delegate = self
        roomTextField.isHidden = true
        roomLabel.text = room
        roomLabel.isUserInteractionEnabled = true
        let roomTapGesture = UITapGestureRecognizer(target: self, action: #selector(EditViewController.roomLabelTapped))
        roomTapGesture.numberOfTouchesRequired = 1
        roomLabel.addGestureRecognizer(roomTapGesture)
        
        //set up box name components
        boxTextField.delegate = self
        boxTextField.isHidden = true
        boxLabel.text = box
        boxLabel.isUserInteractionEnabled = true
        let boxTapGesture = UITapGestureRecognizer(target: self, action: #selector(EditViewController.boxLabelTapped))
        boxTapGesture.numberOfTouchesRequired = 1
        boxLabel.addGestureRecognizer(boxTapGesture)
        
        //set up quantity components
        quantityTextField.delegate = self
        quantityTextField.isHidden = true
        quantityLabel.text = quantity
        quantityLabel.isUserInteractionEnabled = true
        let quantityTapGesture = UITapGestureRecognizer(target: self, action: #selector(EditViewController.quantityLabelTapped))
        quantityTapGesture.numberOfTouchesRequired = 1
        quantityLabel.addGestureRecognizer(quantityTapGesture)
        
        //set up description components
        descriptionTextField.delegate = self
        descriptionTextField.isHidden = true
        descriptionLabel.text = d
        descriptionLabel.isUserInteractionEnabled = true
        let descriptionTapGesture = UITapGestureRecognizer(target: self, action: #selector(EditViewController.descriptionLabelTapped))
        descriptionTapGesture.numberOfTouchesRequired = 1
        descriptionLabel.addGestureRecognizer(descriptionTapGesture)
    }
    
    //https://stackoverflow.com/questions/31446237/how-can-i-edit-a-uilabel-upon-touching-it-in-swift
    @objc func namelabelTapped()
    {
        nameLabel.isHidden = true
        nameTextField.isHidden = false
        nameTextField.text = nameLabel.text
    }
    
    @objc func roomLabelTapped()
    {
        roomLabel.isHidden = true
        roomTextField.isHidden = false
        roomTextField.text = roomLabel.text
    }
    
    @objc func boxLabelTapped()
    {
        boxLabel.isHidden = true
        boxTextField.isHidden = false
        boxTextField.text = boxLabel.text
    }
    
    @objc func quantityLabelTapped()
    {
        quantityLabel.isHidden = true
        quantityTextField.isHidden = false
        quantityTextField.text = quantityLabel.text
    }
    
    @objc func descriptionLabelTapped()
    {
        descriptionLabel.isHidden = true
        descriptionTextField.isHidden = false
        descriptionTextField.text = descriptionLabel.text
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == nameTextField
        {
            textField.resignFirstResponder()
            nameTextField.isHidden = true
            nameLabel.isHidden = false
            nameLabel.text = nameTextField.text
        }
        if textField == roomTextField
        {
            textField.resignFirstResponder()
            roomTextField.isHidden = true
            roomLabel.isHidden = false
            roomLabel.text = roomTextField.text
        }
        
        if textField == boxTextField
        {
            textField.resignFirstResponder()
            boxTextField.isHidden = true
            boxLabel.isHidden = false
            boxLabel.text = boxTextField.text
        }
        if textField == quantityTextField
        {
            textField.resignFirstResponder()
            quantityTextField.isHidden = true
            quantityLabel.isHidden = false
            quantityLabel.text = quantityTextField.text
        }
        if textField == descriptionTextField
        {
            textField.resignFirstResponder()
            descriptionTextField.isHidden = true
            descriptionLabel.isHidden = false
            descriptionLabel.text = descriptionTextField.text
        }
    
        return true
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
//    {
//        if textField == quantityTextField
//        {
//            if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil
//            {
//                bool = true
//            }
//        }
//        return bool
//    }
    func update()
    {
        let uid = Auth.auth().currentUser?.uid
        let ref: DatabaseReference = Database.database().reference()
        
        let roomName = roomLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let boxName = boxLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let itemName = nameLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let description = descriptionLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let q = quantityLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
//        if bool == true
//        {
//            quantityToStore = quantityLabel.text
//        }
//        else
//        {
//            let alert = UIAlertController(title: "Error", message: "Quantity must be an integer", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler:
//                { (UIAlertAction) in
//                    NSLog("The \"OK\" alert occured.")
//                }))
//                self.present(alert, animated: true, completion: nil)
//        }
        
        let itemDict: [String: Any] = [ "Room": roomName, "Box": boxName,"Description": description, "Quantity": q, "Name": itemName]
        ref.child("users").child(uid!).child("Items").child(itemName).setValue(itemDict)
        
        
    }
    
    @IBAction func updateButtonTapped(_ sender: Any)
    {
        update()
        let alert = UIAlertController(title: "Success", message: "Item has been updated!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler:
            { (UIAlertAction) in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
         let vc = storyboard?.instantiateViewController(identifier: "searchVC") as? SearchViewController
         self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any)
    {
        let uid = Auth.auth().currentUser?.uid
        let ref: DatabaseReference = Database.database().reference()
        
        let itemName = nameTextField.text
        ref.child("users").child(uid!).child("Items").child(itemName!).removeValue()
        let vc = storyboard?.instantiateViewController(identifier: "searchVC") as? SearchViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView == roomPickerView
        {
            return rooms.count
        }
        if pickerView == boxPickerView
        {
            return boxes.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == roomPickerView
        {
            return rooms[row]
        }
        if pickerView == boxPickerView
        {
            return boxes[row]
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == roomPickerView
        {
            roomTextField.text = rooms[row]
            roomTextField.resignFirstResponder()
        }
        if pickerView == boxPickerView
        {
            boxTextField.text = boxes[row]
            boxTextField.resignFirstResponder()
        }
    }
}
