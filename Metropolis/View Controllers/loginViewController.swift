//
//  loginViewController.swift
//  Metropolis
//
//  Created by Nik Dev on 4/19/20.
//  Copyright © 2020 Nikhil Devadoss. All rights reserved.
//

import UIKit
import Firebase

class loginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginButtonPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if(error == nil){
                print("User signed in successfully!")
                self.performSegue(withIdentifier: "toLandingPage", sender: self)
            }
            else{
                let myAlert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert) //you can change message to whatever you want.
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }
        }
    }
    
}
