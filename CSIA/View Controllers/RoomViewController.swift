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
        
    var roomList : [String] = []
    var roomName: String!

    override func viewDidLoad()
    {
        // Do any additional setup after loading the view.
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        displayRooms()
    }

func displayRooms()
{
    let uid = Auth.auth().currentUser?.uid
    let ref: DatabaseReference = Database.database().reference()
    ref.child("users").child(uid!).child("Items").observe(.value)
    { (DataSnapshot) in
        if let dict = DataSnapshot.value as? [String: AnyObject]
                {
                    for itemName in dict.keys
                    {
                       ref.child("users").child(uid!).child("Items").child(itemName).observe(.value)
                        { (DataSnapshot) in
                            if let dict =  DataSnapshot.value as? [String: AnyObject]
                                {
                                    self.roomName = dict["Room"] as? String
                                    self.roomList.append(self.roomName!)
                    
                                    let roomindexPath = IndexPath(row: self.roomList.count-1, section: 0)
                                    self.tableView.insertRows(at: [roomindexPath], with: .automatic)
                                }
                        }

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
        return roomList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = roomList[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 17)
       return cell
    }
}
