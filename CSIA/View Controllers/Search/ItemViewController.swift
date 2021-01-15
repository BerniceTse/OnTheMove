//
//  ItemViewController.swift
//  CSIA
//
//  Created by Bernice Tse on 17/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ItemViewController: UIViewController
{

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var boxName: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    var item = ""
    var room = ""
    var box = ""
    var q = ""
    var descrip = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
        itemName.text = item
        roomName.text = room
        boxName.text = box
        quantity.text = q
        des.text = descrip
        // Do any additional setup after loading the view.
    }

    @IBAction func editButtonTapped(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(identifier: "editVC") as? EditViewController
        vc?.name = item
        vc?.room = roomName.text!
        vc?.box = boxName.text!
        vc?.quantity = quantity.text!
        vc?.d = des.text!
        self.navigationController?.pushViewController(vc!, animated: true)
    }


}
