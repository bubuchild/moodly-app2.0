//
//  ViewController.swift
//  Moodly2.0
//
//  Created by Now chill bubu on 05/11/2020.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool){
     super.viewDidAppear(animated)
     if Auth.auth().currentUser != nil {
       self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
    }
    }
    
}
