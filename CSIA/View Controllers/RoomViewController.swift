//
//  RoomViewController.swift
//  CSIA
//
//  Created by Bernice Tse on 16/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class RoomViewController: UIViewController
{
    @IBOutlet var tableView: UITableView!
        
    //need to retrive items with same name from different boxes/rooms
    
    var roomList = [String]()
    var itemList = [String] ()
    var boxList = [String]()

    
    override func viewDidLoad()
    {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        displayItems()
    }


func displayItems()
{

    let uid = Auth.auth().currentUser?.uid
    let ref: DatabaseReference = Database.database().reference()
    ref.child("users").child(uid!).child("Rooms").observeSingleEvent(of: .value, with: { (DataSnapshot) in

        if let dict = DataSnapshot.value as? [String: AnyObject]
        {
            for roomName in dict.keys
            {
                self.roomList.append(roomName)

//                let roomindexPath = IndexPath(row: self.roomList.count-1, section: 0)
//                self.tableView.insertRows(at: [roomindexPath], with: .automatic)
                
            ref.child("users").child(uid!).child("Rooms").child(roomName).child("Boxes").observeSingleEvent(of: .value, with: { (DataSnapshot) in

                        if let dict = DataSnapshot.value as? [String: AnyObject]
                        {
                            for boxName in dict.keys
                            {
                                self.boxList.append(boxName)
                    
                                //https://www.youtube.com/watch?v=VZgc7LHuQ_0
                                let boxindexPath = IndexPath(row: self.boxList.count-1, section: 0)
                                self.tableView.insertRows(at: [boxindexPath], with: .automatic)
                            ref.child("users").child(uid!).child("Rooms").child(roomName).child("Boxes").child(boxName).child("Items").observeSingleEvent(of: .value, with: { (DataSnapshot) in

                                    if let dict = DataSnapshot.value as? [String: AnyObject]
                                    {
                                        for itemName in dict.keys
                                        {
                                            self.itemList.append(itemName)
                                            
//                                            let itemindexPath = IndexPath(row: self.itemList.count-1, section: 0)
//                                            self.tableView.insertRows(at: [itemindexPath], with: .automatic)
                                        }
                                    }

                                }, withCancel: nil)
                            }
                        }

                    }, withCancel: nil)
                }
            }

    }, withCancel: nil)
    
    for item in roomList
    {
        let query = ref.child("users").child(uid!).child(item)
        query.observe(.value) { (DataSnapshot) in
            for snap in DataSnapshot.children
            {
                let id = snap as! DataSnapshot
                let keyD = id.key
                print("Hello"+keyD)
            }
        }
    }
   
}
    
}


extension RoomViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //direct user to item page
        print("Tapped")

    }
}

//https://www.youtube.com/watch?v=C36sb5sc6lE
extension RoomViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return boxList.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        cell.roomName?.text = roomList[indexPath.row]
        cell.boxName?.text = boxList[indexPath.row]
        cell.itemCount?.text = String (itemList.count)
        
        return cell
        
    }

}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

