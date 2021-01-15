//
//  SearchViewController.swift
//  CSIA
//
//  Created by Bernice Tse on 16/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class SearchViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    //need to retrive items with same name from different boxes/rooms
    var roomList = [String]()
    var itemList = [String] ()
    var itemModelList = [ItemModel]()
    var boxList = [String]()
    var userList = [String]()
    var searching = false
    var selectedItem: String?
    var roomToStore: String!
    var boxToStore: String!
    var itemToStore: String!
    var descriptionToStore: String?
    var quantityToStore: String!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        getItems()
    
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

func getItems()
{
    let uid = Auth.auth().currentUser?.uid
    let ref: DatabaseReference = Database.database().reference()
    ref.child("users").child(uid!).child("Items").observeSingleEvent(of: .value)
    { (DataSnapshot) in
       if let dict = DataSnapshot.value as? [String: AnyObject]
                  {
                      for itemName in dict.keys
                      {
                            self.itemList.append(itemName)
                            let itemindexPath = IndexPath(row: self.itemList.count-1, section: 0)
                            self.tableView.insertRows(at: [itemindexPath], with: .automatic)
                        
                        ref.child("users").child(uid!).child("Items").child(itemName).observe(.value) { (DataSnapshot) in

                            if let dict =  DataSnapshot.value as? [String: AnyObject]
                            {
                                self.itemToStore = dict["Name"] as? String
                                self.roomToStore = dict["Room"] as? String
                                self.boxToStore = dict["Box"] as? String
                                self.quantityToStore = dict["Quantity"] as? String
                                self.descriptionToStore = dict["Description"] as? String
                            
                                let itemModel = ItemModel(name: self.itemToStore, box: self.boxToStore, room: self.roomToStore, quantity: self.quantityToStore, description: self.descriptionToStore )
                                self.itemModelList.append(itemModel)
                            }
                        }
                    }
                }
    }
}
    
}

extension SearchViewController: UISearchBarDelegate
{
    //https://www.youtube.com/watch?v=wVeX68Iu43E
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        userList = itemList.filter({$0.prefix(searchText.count) == searchText})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //direct user to item page: https://www.youtube.com/watch?v=hGV9pfssmXA
        let vc = storyboard?.instantiateViewController(identifier: "ItemViewController") as? ItemViewController
        let cell = tableView.cellForRow(at: indexPath)
        
        selectedItem = cell?.textLabel?.text
        
        //pass item name
        vc?.item = selectedItem!
        
        for item in itemModelList
          {
              if item.getName() == selectedItem
              {
                  let selectedRoom = item.getRoom()!
                  vc?.room = selectedRoom
                  let selectedBox = item.getBox()!
                  vc?.box = selectedBox
                  let selectedQuantity = item.getQuantity()!
                  vc?.q = selectedQuantity
                  let selectedDescription = item.getDescription()!
                  vc?.descrip = selectedDescription
              }
          }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
    
//https://www.youtube.com/watch?v=C36sb5sc6lE
extension SearchViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if searching == true
        {
            return userList.count
        }
        else
        {
            return itemList.count
        }
    }
    
    //populate the cells with potential searches
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = itemList[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Avenir Next", size:17);
        if searching == true
        {
            cell.textLabel?.text = userList[indexPath.row]
            
        }
        else
        {
            cell.textLabel?.text = itemList[indexPath.row]
        }
        return cell
    }
}
//let uid = Auth.auth().currentUser?.uid
//let ref: DatabaseReference = Database.database().reference()

       //pass room name
//       ref.child("users").child(uid!).child("Items").child(selectedItem!).child("Room").observe(.value)
//       { (DataSnapshot) in
//           self.selectedRoom = DataSnapshot.value as? String
//           vc?.roomName.text = self.selectedRoom!
//       }
//       //pass box name
//       ref.child("users").child(uid!).child("Items").child(selectedItem!).child("Box").observe(.value)
//       { (DataSnapshot) in
//           self.selectedBox = DataSnapshot.value as? String
//           if self.selectedBox != nil
//           {
//               vc?.boxName.text = self.selectedBox!
//           }
//       }
//       //pass quantity
//   ref.child("users").child(uid!).child("Items").child(selectedItem!).child("Quantity").observe(.value)
//       { (DataSnapshot) in
//           self.selectedQuantity = DataSnapshot.value as? String
//           if self.selectedQuantity != nil
//           {
//               vc?.quantity.text = self.selectedQuantity!
//           }
//       }
//       //pass description
//       ref.child("users").child(uid!).child("Items").child(selectedItem!).child("Description").observe(.value)
//       { (DataSnapshot) in
//           self.selectedDescription = DataSnapshot.value as? String
//           if self.selectedDescription != nil
//           {
//               vc?.des.text = self.selectedDescription!
//           }
//       }


//



