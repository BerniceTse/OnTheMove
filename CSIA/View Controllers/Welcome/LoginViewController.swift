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
  
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements()
    {
        errorLabel.alpha = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginButtonTapped(_ sender: Any)
    {
    //validate text fields
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    //sign up as user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else{
                let mainTabController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.MainTabController) as? MainTabController
                self.view.window?.rootViewController = mainTabController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
}
