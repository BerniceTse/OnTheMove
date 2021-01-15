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
    func whenTapped(label: UILabel, textfield: UITextField)
    {
        label.isHidden = true
        textfield.isHidden = false
        textfield.text = label.text
    }
    
    @objc func namelabelTapped()
    {
        whenTapped(label: nameLabel, textfield: nameTextField)
    }
    
    @objc func roomLabelTapped()
    {
        whenTapped(label: roomLabel, textfield: roomTextField)
    }
    
    @objc func boxLabelTapped()
    {
        whenTapped(label: boxLabel, textfield: boxTextField)
    }
    
    @objc func quantityLabelTapped()
    {
        whenTapped(label: quantityLabel, textfield: quantityTextField)
    }
    
    @objc func descriptionLabelTapped()
    {
        whenTapped(label: descriptionLabel, textfield: descriptionTextField)
    }
    
    func displayText(label: UILabel, textfield: UITextField)
    {
        textfield.resignFirstResponder()
        textfield.isHidden = true
        label.isHidden = false
        label.text = textfield.text
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == nameTextField
        {
            displayText(label: nameLabel, textfield: nameTextField)
        }
        if textField == roomTextField
        {
            displayText(label: roomLabel, textfield: roomTextField)
        }
        
        if textField == boxTextField
        {
            displayText(label: boxLabel, textfield: boxTextField)
        }
        if textField == quantityTextField
        {
            displayText(label: quantityLabel, textfield: quantityTextField)
        }
        if textField == descriptionTextField
        {
            displayText(label: descriptionLabel, textfield: descriptionTextField)
        }
        return true
    }
    

    func update()
    {
        let uid = Auth.auth().currentUser?.uid
        let ref: DatabaseReference = Database.database().reference()
        
        let roomName = roomLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let boxName = boxLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let itemName = nameLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let description = descriptionLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let q = quantityLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let itemDict: [String: Any] = [ "Room": roomName, "Box": boxName,"Description": description, "Quantity": q, "Name": itemName]
        ref.child("users").child(uid!).child("Items").child(itemName).setValue(itemDict)
    }
    
    @IBAction func updateButtonTapped(_ sender: Any)
    {
        if roomLabel.text == "" || boxLabel.text == "" || nameLabel.text == ""
        {
            let alert = UIAlertController(title: "Error", message: "Please ensure you have inputted all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler:
                { (UIAlertAction) in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
        }
        if quantityLabel.text == "0"
        {
            let alert = UIAlertController(title: "Error", message: "Quantity cannot be zero", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler:
                { (UIAlertAction) in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
        }
        else
        {
        update()
        let alert = UIAlertController(title: "Success", message: "Item has been updated!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler:
            { (UIAlertAction) in
                NSLog("The \"OK\" alert occured.")
                let vc = self.storyboard?.instantiateViewController(identifier: "searchVC") as? SearchViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    

    @IBAction func deleteButtonTapped(_ sender: Any)
    {
        let uid = Auth.auth().currentUser?.uid
        let ref: DatabaseReference = Database.database().reference()
        
        let confirmation = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default)
        { (UIAlertAction) in
            let itemName = self.nameLabel.text!
            ref.child("users").child(uid!).child("Items").child(itemName).removeValue()
            let vc = self.storyboard?.instantiateViewController(identifier: "searchVC") as? SearchViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        { (UIAlertAction) in
            print("cancel button tapped")
        }
        confirmation.addAction(yes)
        confirmation.addAction(cancel)
        self.present(confirmation, animated: true, completion: nil)
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
