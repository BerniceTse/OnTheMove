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
    
    let rooms = ["Bathroom", "Dining Room", "Kitchen", "Living Room" ]
    let boxes = ["Tray", "Cupboard", "Shelf", "Drawer"]
    
    var quantity = 0
    
    
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
        roomField.textAlignment = .center
        roomField.placeholder = "Select Room"
        
        boxField.inputView = boxPickerView
        boxField.textAlignment = .center
        boxField.placeholder = "Select Box"
        

        // Do any additional setup after loading the view.
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
        //get Strings from textfields
        let roomName = roomField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let boxName = boxField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let itemName = itemNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let description = descriptionLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //create room and box models
        let room = RoomModel(roomName: roomName, boxesList: [], boxCount: 0)
        let box = BoxModel(boxName: boxName, itemsList: [], itemCount: 0)
        let item = ItemModel(name: itemName, box: box, room: room, quantity: quantity, description: description)
      
        room.addBox(box: box)
        
        //obtain current user id
        let uid = Auth.auth().currentUser?.uid
        
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (DataSnapshot) in
            print(DataSnapshot)
        }, withCancel: nil)
        
       // store relevant information in Firebase
        ref.child("users").child(uid!).child("Rooms").child(roomName).child("Name").setValue(roomName)
        ref.child("users").child(uid!).child("Rooms").child(roomName).child("Boxes").child(boxName).child("Name").setValue(boxName)
        ref.child("users").child(uid!).child("Rooms").child(roomName).child("Boxes").child(boxName).child("Items").child(itemName).child("Name").setValue(itemName)
        
        ref.child("users").child(uid!).child("Rooms").child(roomName).child("Boxes").child(boxName).child("Items").child(itemName).child("Quantity").setValue(quantity)
        ref.child("users").child(uid!).child("Rooms").child(roomName).child("Boxes").child(boxName).child("Items").child(itemName).child("Decription").setValue(description)
        
        
        clear(textfield: roomField)
        clear(textfield: boxField)
        clear(textfield: itemNameTextField)
        clear(textfield: descriptionLabel)
    
    }
     
    //https://www.youtube.com/watch?v=fLJVBbVEpBg
    @IBAction func stepper(_ sender: UIStepper)
    {
        quantity = Int(sender.value)
        quantityLabel.text = String( sender.value)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
