//
//  LoginViewController.swift
//  Proyecto Integrador
//
//  Created by Digital House on 14/6/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit
import FirebaseUI
import GoogleSignIn

class LoginViewController: UIViewController, FUIAuthDelegate {
    
    var authUI: FUIAuth?
    
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginButtom(_ sender: UIButton) {
        if Auth.auth().currentUser == nil {
            if let authViewController = self.authUI?.authViewController() {
                present(authViewController, animated: true, completion: nil)
            }
        }
    }
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(displayP3Red: 66/255, green: 42/255, blue: 87/255, alpha: 1)
        
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "loginSegue", sender: self)
        }
        
        self.authUI = FUIAuth.defaultAuthUI()
        self.authUI?.delegate = self
        
        let providers: [FUIAuthProvider] = [FUIGoogleAuth()]
        
        self.authUI?.providers = providers
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}
