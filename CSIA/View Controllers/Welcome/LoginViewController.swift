//
//  LoginViewController.swift
//  CSIA
//
//  Created by Bernice Tse on 16/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements()
    {
        errorLabel.alpha = 0
    }
    
    func validateFields() -> String?
    {
        //check all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||   passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        return nil
    }
    
    func showError( message: String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    @IBAction func loginButtonTapped(_ sender: Any)
    {
        let error = validateFields()
        if error != nil
        {
            showError(message: error!)
        }
        else
        {
        //store user inputs as local variables
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //login as user
        Auth.auth().signIn(withEmail: email, password: password)
        { (result, error) in
            if error != nil
            {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else
            {
                let mainTabController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.MainTabController) as? MainTabController
                self.view.window?.rootViewController = mainTabController
                self.view.window?.makeKeyAndVisible()
            }
        }
        }
    }
}

