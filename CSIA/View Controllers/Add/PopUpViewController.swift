//
//  PopUpViewController.swift
//  CSIA
//
//  Created by Bernice Tse on 13/1/2021.
//  Copyright © 2021 Bernice Tse. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController
{

    @IBOutlet weak var roomName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonTapped(_ sender: Any)
    {
        let room = roomName.text
        let vc = storyboard?.instantiateViewController(identifier: "AddVC") as? AddViewController
        vc?.roomField?.text = room!
        self.navigationController?.pushViewController(vc!, animated: true)
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
