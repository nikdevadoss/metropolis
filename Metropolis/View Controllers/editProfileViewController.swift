//
//  editProfileViewController.swift
//  Metropolis
//
//  Created by Nik Dev on 5/18/20.
//  Copyright © 2020 Nikhil Devadoss. All rights reserved.
//

import UIKit
import Firebase

class editProfileViewController: UIViewController {

    @IBOutlet weak var passwordRetypeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameTextField.placeholder = Auth.auth().currentUser?.displayName
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveProfile(_ sender: Any) {
//        let ref = Database.database().reference()
        var tempError = 0
        if(usernameTextField.text != ""){
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = usernameTextField.text
            changeRequest?.commitChanges(completion: { (error) in
                if(error == nil){
                    print("display name changed successfully!")
//                    ref.child("Users").child(Auth.auth().currentUser!.uid).setValue(self.usernameTextField.text!, forKey: "username")
                    let db = Firebase.Firestore.firestore()
                    db.collection("Users").document(Auth.auth().currentUser!.uid).updateData(["username" : self.usernameTextField.text!])
                    
                    print("Username changed successfully!")
                    tempError = 0
                }
                else{
                    tempError = 1
                }
            })
            
        }
        if(passwordTextField.text != ""){
            if(passwordRetypeTextField.text != passwordTextField.text){
                let myAlert = UIAlertController(title: "Error", message: "Passwords are not the same, please try again", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
                tempError = 1
            }
            else{
                Auth.auth().currentUser?.updatePassword(to: passwordTextField.text!, completion: { (error) in
                    if(error == nil){
                        print("Password changed successfully!")
                        tempError = 0
                    }
                    else{
                        let myAlert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        myAlert.addAction(okAction)
                        self.present(myAlert, animated: true, completion: nil)
                        tempError = 1
                    }
                })
            }
        }
        
        if(tempError == 0){
            let myAlert = UIAlertController(title: "Update", message: "User profile has been updated successfully!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
    }
    
}
