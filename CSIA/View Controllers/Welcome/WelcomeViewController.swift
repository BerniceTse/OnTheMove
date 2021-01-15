//
//  WelcomeViewController.swift
//  CSIA
//
//  Created by Bernice Tse on 16/8/2020.
//  Copyright © 2020 Bernice Tse. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController
{

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //https://www.youtube.com/watch?v=Lh8Iztqbwg0
        iconImageView.image = UIImage(named: "OnTheMove")
    }
    
}
