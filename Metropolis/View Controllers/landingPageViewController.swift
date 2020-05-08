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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if(Auth.auth().currentUser != nil){
            self.performSegue(withIdentifier: "toTabBar", sender: self)
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

}
