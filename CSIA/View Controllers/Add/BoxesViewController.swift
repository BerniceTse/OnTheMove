//
//  BoxesViewController.swift
//  CSIA
//
//  Created by Bernice Tse on 17/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class BoxesViewController: UIViewController {

  
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var boxName: UILabel!
    @IBOutlet weak var roomName: UILabel!
    
    //need to retrive items with same name from different boxes/rooms
        var itemList = [String]()
        
        override func viewDidLoad()
        {
            super.viewDidLoad()

            tableView.delegate = self
            tableView.dataSource = self
            // Do any additional setup after loading the view.
        }
    func displayItems()
    {
        let uid = Auth.auth().currentUser?.uid
            let ref: DatabaseReference = Database.database().reference()
            ref.child("users").child(uid!).child("Items").observeSingleEvent(of: .value)
            { (DataSnapshot) in
                
               if let dict = DataSnapshot.value as? [String: AnyObject]
                          {
                              for itemName in dict.keys
                              {
                                    ref.child("users").child(uid!).child("Items").child(itemName).observe(.value)
                                    { (DataSnapshot) in
                                    
                                        if let dict =  DataSnapshot.value as? [String: AnyObject]
                                        {
                                            if dict["Room"] as? String == self.roomName.text
                                            {
                                                let item = dict["Name"] as? String
                                                self.itemList.append(item!)
                                                let itemindexPath = IndexPath(row: self.itemList.count-1, section: 0)
                                                self.tableView.insertRows(at: [itemindexPath], with: .automatic)
                                            }
                                           
    
                                                
                                        }
                                    }
                                        
                                }
                            }
                            
    
        
        }
    }
    
}
    extension BoxesViewController: UITableViewDelegate
    {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            //direct user to item page
            print("Tapped")
            
        }
    }

    //https://www.youtube.com/watch?v=C36sb5sc6lE
    extension BoxesViewController: UITableViewDataSource
    {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = itemList[indexPath.row]
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

