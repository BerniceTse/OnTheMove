//
//  ProfileViewController.swift
//  CSIA
//
//  Created by Bernice Tse on 16/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
   
    var ref: DatabaseReference!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: "OnTheMove")
        setUpElements()
        }
    
    func setUpElements()
       {
           errorLabel.alpha = 0
       }
    
    func showError( message: String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    @IBAction func logOutButtonTapped(_ sender: Any)
    {
        print("Tapped")
        let auth = Auth.auth()
        do
        {
            try auth.signOut()
            self.dismiss(animated: true, completion: nil)
        }
        catch
        {
            self.showError(message: "Error signing out")
        }
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


