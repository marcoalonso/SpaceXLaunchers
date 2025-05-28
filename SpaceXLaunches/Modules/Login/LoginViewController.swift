//
//  LoginViewController.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 28/05/25.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var onRegisterTap: (() -> Void)?
    var onLoginSuccess: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func loginTapped(_ sender: UIButton) {
        
    }
    
    
    @IBAction func goToRegister(_ sender: UIButton) {
        
    }
    
}
