//
//  SignUpViewController.swift
//  CSIA
//
//  Created by Bernice Tse on 16/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase


//https://www.youtube.com/watch?v=1HN7usMROt8
class SignUpViewController: UIViewController {
    

    var ref: DatabaseReference = Database.database().reference()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements()
    {
        errorLabel.alpha = 0
    }
    
    
    func validateFields() -> String?
    {
        //check all fields are filled in
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        //check password is secure
        
        return nil
    }
    
    func showError( message: String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome()
    {

        let mainTabController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.MainTabController) as? MainTabController
        
        view.window?.rootViewController = mainTabController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func signUpTapped(_ sender: Any)
    {
        //validate fields
        let error = validateFields()
        if error != nil
        {
            showError(message: error!)
        }
        else
        {
         
            let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
            //create new user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                //check errors
                if err != nil
                {
                    self.showError(message: "Error creating user")
                }
                else
                {
                    //user created successfully
                    self.ref.child("users").child(result!.user.uid).child("Personal Information").child("email").setValue(email)
                    self.ref.child("users").child(result!.user.uid).child("Personal Information").child("username").setValue(username)
                    self.ref.child("users").child(result!.user.uid).child("Personal Information").child("userid").setValue(result!.user.uid)
                
                    let userID = Auth.auth().currentUser?.uid
                    _ = UserModel(uid: userID, username: username, email:email)
            }
        
        //direct to homescreen
            self.transitionToHome()
            
        }
    }
    

    }
    
}
