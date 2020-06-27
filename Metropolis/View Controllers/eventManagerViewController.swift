//
//  eventManagerViewController.swift
//  Metropolis
//
//  Created by Nik Dev on 6/22/20.
//  Copyright © 2020 Nikhil Devadoss. All rights reserved.
//

import UIKit
import Firebase

class eventManagerViewController: UIViewController {

    @IBOutlet weak var eventLocation: UITextField!
    @IBOutlet weak var eventDate: UITextField!
    @IBOutlet weak var eventName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func addEvent(_ sender: Any) {
        let db = Firestore.firestore()
        if(eventLocation.text == "" || eventDate.text == "" || eventName.text == ""){
            let myAlert = UIAlertController(title: "Error", message: "An event field is left unfilled, please try again", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            eventName.text = ""
            eventDate.text = ""
            eventLocation.text = ""
            self.view.reloadInputViews()
        }
        else{
            db.collection("Events").addDocument(data: ["eventName" : eventName.text!, "eventDate": eventDate.text!, "eventLocation": eventLocation.text!, "eventOrganizer": "", "organizerUID": Auth.auth().currentUser?.uid as Any])
            let myAlert = UIAlertController(title: "Success!", message: "Event has been successfully created", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            eventName.text = ""
            eventDate.text = ""
            eventLocation.text = ""
            self.view.reloadInputViews()
        }
    }
}
