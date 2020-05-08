//
//  registerViewController.swift
//  Metropolis
//
//  Created by Nik Dev on 4/19/20.
//  Copyright © 2020 Nikhil Devadoss. All rights reserved.
//

import UIKit
import Firebase

class registerViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
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
    @IBAction func registerPressed(_ sender: Any) {
        //let db = Firebase.Firestore.firestore()
        let email = emailTextField.text!
        if(!isValidEmail(email)){
            let error = "Email is not valid, requires .edu domain"
            let myAlert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        else{
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if(error == nil){
                    print("User created successfully!")
                    self.performSegue(withIdentifier: "toLandingPage", sender: self)
                }
                else{
                    let myAlert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.edu"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
