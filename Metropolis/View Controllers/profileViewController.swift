//
//  profileViewController.swift
//  Metropolis
//
//  Created by Nik Dev on 5/8/20.
//  Copyright © 2020 Nikhil Devadoss. All rights reserved.
//

import UIKit
import Firebase

class profileViewController: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //let db = Firebase.Firestore.firestore()
        //usernameLabel.text = (db.collection("Users").document(Auth.auth().currentUser!.uid).value(forKey: "username") as! String)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let db = Firebase.Firestore.firestore()
        db.collection("Users").document(Auth.auth().currentUser!.uid).getDocument { (document, error) in
            //document?.get("username")
            self.usernameLabel.text = document?.get("username") as? String
            self.emailLabel.text = document?.get("email") as? String
        }    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logoutPressed(_ sender: Any) {
        var success = false
        do{
            try Auth.auth().signOut()
            success = true
        }
        catch{
            
        }
        if(success){
            self.performSegue(withIdentifier: "toLandingPage", sender: self)
        }
    }
    
}
