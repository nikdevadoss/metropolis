//
//  eventsManagerViewController.swift
//  Metropolis
//
//  Created by Nik Dev on 5/16/20.
//  Copyright © 2020 Nikhil Devadoss. All rights reserved.
//

import UIKit
import Firebase

class eventsManagerViewController: UIViewController {

    @IBOutlet weak var eventLocation: UITextField!
    @IBOutlet weak var eventDate: UITextField!
    @IBOutlet weak var eventName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func addEvent(_ sender: Any) {
        let db = Firebase.Firestore.firestore()
        if(eventDate == nil || eventName == nil || eventLocation == nil){
            let myAlert = UIAlertController(title: "Error", message: "A value is not filled, please complete information and try again", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        else{
            db.collection("Events").addDocument(data: ["eventName" : eventName.text!, "eventData": eventDate.text!, "eventLocation": eventLocation.text!, "eventOrganizer": Auth.auth().currentUser?.displayName as Any])
            let myAlert = UIAlertController(title: "Update", message: "Event has been successfully created", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
    }
}
