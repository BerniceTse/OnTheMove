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

class ProfileViewController: UIViewController
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
   
    var ref: DatabaseReference!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        imageView.image = UIImage(named: Constants.Storyboard.OnTheMove)
        setUpElements()
        displayInfo()
    }
    
    func setUpElements()
    {
        errorLabel.alpha = 0
    }
    
    func displayInfo()
    {
        let uid = Auth.auth().currentUser?.uid
        let ref: DatabaseReference = Database.database().reference()
    ref.child(Constants.Storyboard.FirebaseUser).child(uid!).child(Constants.Storyboard.FirebasePersonalInformation).child(Constants.Storyboard.UserUsername).observe(.value)
        { (DataSnapshot) in
            if DataSnapshot.exists()
            {
                let username = DataSnapshot.value as! String
                self.usernameLabel.text = username
            }
        }
    ref.child(Constants.Storyboard.FirebaseUser).child(uid!).child(Constants.Storyboard.FirebasePersonalInformation)
        .child(Constants.Storyboard.UserEmail).observe(.value)
        { (DataSnapshot) in
            if DataSnapshot.exists()
            {
                let email = DataSnapshot.value as! String
                self.emailLabel.text = email
            }
        }
    }
    
    func showError( message: String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome()
    {
        let mainTabController = storyboard?.instantiateViewController(identifier: "HomeVC") as? UINavigationController
        view.window?.rootViewController = mainTabController
        view.window?.makeKeyAndVisible()
    }
    
    //https://www.youtube.com/watch?v=7LXEU5QzPOU
    @IBAction func logOutButtonTapped(_ sender: Any)
    {
        let auth = Auth.auth()
        do
        {
            try auth.signOut()
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "isUserSignedIn")
            transitionToHome()
        }
        catch
        {
            self.showError(message: "Error signing out")
        }
    }
}
