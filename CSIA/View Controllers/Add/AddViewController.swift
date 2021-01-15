//
//  AddViewController.swift
//  CSIA
//
//  Created by Bernice Tse on 16/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var ref: DatabaseReference = Database.database().reference()
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var roomField: UITextField!
    @IBOutlet weak var boxField: UITextField!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    let rooms = ["Bathroom", "Bedroom", "Dining Room", "Kitchen", "Living Room", "Other"]
    let boxes = ["Tray", "Cupboard", "Shelf", "Drawer"]
    
    var quantity = ""
    var roomCount = 0

    var roomPickerView = UIPickerView()
    var boxPickerView = UIPickerView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Pickerview: https://www.youtube.com/watch?v=QdLFd3wNqV8
        roomPickerView.delegate = self
        roomPickerView.dataSource = self
        boxPickerView.delegate = self
        boxPickerView.dataSource = self
        
        roomField.inputView = roomPickerView
        roomField.placeholder = "Select Room"
        
        boxField.inputView = boxPickerView
        boxField.placeholder = "Select Box"
    }
    // returns the number of 'columns' to display.

    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }

    // returns the # of rows in each component..
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
            roomField.text = rooms[row]
            roomField.resignFirstResponder()
        }
        if pickerView == boxPickerView
        {
            boxField.text = boxes[row]
            boxField.resignFirstResponder()
        }
    }
    
    func clear(textfield: UITextField)
    {
        textfield.text = ""
    }
    
    @IBAction func addButtonTapped(sender:Any)
    {
        //error catching: https://developer.apple.com/documentation/uikit/uialertcontroller
        if roomField.text == "" || boxField.text == "" || itemNameTextField.text == ""
        {
            let alert = UIAlertController(title: "Error", message: "Please ensure you have inputted all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler:
                { (UIAlertAction) in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
        }
        if quantity == "0"
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
            //get user input from textfields
            let roomName = roomField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let boxName = boxField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let itemName = itemNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let description = descriptionLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //obtain current user id
            let uid = Auth.auth().currentUser?.uid
                
            //store relevant information in Firebase: https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html
            let itemDict: [String: Any] = [ "Room": roomName, "Box": boxName,"Description": description, "Quantity": quantity, "Name": itemName]
            ref.child("users").child(uid!).child("Items").child(itemName).setValue(itemDict)
            
            let alert = UIAlertController(title: "Success", message: "Item added!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler:
                { (UIAlertAction) in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
                
            //clear display
            clear(textfield: roomField)
            clear(textfield: boxField)
            clear(textfield: itemNameTextField)
            clear(textfield: descriptionLabel)
            quantityStepper.value = 1
            quantityLabel.text = "1"

        }
    }
     
    //https://www.youtube.com/watch?v=fLJVBbVEpBg
    @IBAction func stepper(_ sender: UIStepper)
    {
        quantity = String(Int(sender.value))
        quantityLabel.text = String(Int(sender.value))
    }
}

 
