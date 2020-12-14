//
//  BoxesViewController.swift
//  CSIA
//
//  Created by Bernice Tse on 17/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//

import UIKit

class BoxesViewController: UIViewController {

  
     @IBOutlet var tableView: UITableView!
        
        //need to retrive items with same name from different boxes/rooms
        let itemsList = ["Books", "Folders", "Toys"]
        
        override func viewDidLoad()
        {
            super.viewDidLoad()

            tableView.delegate = self
            tableView.dataSource = self
            // Do any additional setup after loading the view.
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
            return itemsList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = itemsList[indexPath.row]
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

