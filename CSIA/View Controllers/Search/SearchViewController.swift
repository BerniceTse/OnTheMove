//
//  SearchViewController.swift
//  CSIA
//
//  Created by Bernice Tse on 16/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    //need to retrive items with same name from different boxes/rooms
    let itemsList = ["a", "b", "c"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    }
extension SearchViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //direct user to item page
        print("Tapped")
        
    }
}

//https://www.youtube.com/watch?v=C36sb5sc6lE
extension SearchViewController: UITableViewDataSource
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
