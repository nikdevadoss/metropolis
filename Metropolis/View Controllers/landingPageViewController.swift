//
//  landingPageViewController.swift
//  Metropolis
//
//  Created by Nik Dev on 5/8/20.
//  Copyright © 2020 Nikhil Devadoss. All rights reserved.
//

import UIKit
import Firebase

class landingPageViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true
        registerButton.layer.cornerRadius = 10
        registerButton.layer.borderWidth = 0.5
        registerButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.cornerRadius = 10
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor = UIColor.white.cgColor
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        if(Auth.auth().currentUser != nil){
            self.performSegue(withIdentifier: "toTabBar", sender: self)
        }
        //self.tabBar.isHidden = true
        
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
