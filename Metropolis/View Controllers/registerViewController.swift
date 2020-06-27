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

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerButton.layer.borderColor = UIColor.white.cgColor
        registerButton.layer.cornerRadius = 10
        registerButton.layer.borderWidth = 0.5
        setupProfileImage()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupProfileImage(){
        profilePicture.layer.cornerRadius = 10
        profilePicture.clipsToBounds = true
        profilePicture.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        profilePicture.addGestureRecognizer(gesture)
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        
    }
    
    @objc func presentPicker(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        
    }
    

    @IBAction func registerPressed(_ sender: Any) {
        let db = Firebase.Firestore.firestore()
        
        let email = emailTextField.text!
        let currImage = profilePicture
        if(!isValidEmail(email)){
            let error = "Email is not valid, requires .edu domain"
            let myAlert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        else{
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if(error == nil){
                    changeRequest?.displayName = self.usernameTextField.text!
                    // changeRequest?.photoURL =
                    changeRequest?.commitChanges(completion: { (error) in
                        if(error == nil){
                            print("display name updated successfully!")
                            print(Auth.auth().currentUser?.displayName)
                        }
                        else{
                            print(error as Any)
                        }
                    })
                    db.collection("Users").document(Auth.auth().currentUser!.uid).setData(["email" : self.emailTextField.text!, "username" : self.usernameTextField.text!, "profilePicture": self.profilePicture.image?.pngData()?.base64EncodedString() as Any])
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

extension registerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if(info[UIImagePickerController.InfoKey.editedImage] as? UIImage != nil) {
            profilePicture.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
