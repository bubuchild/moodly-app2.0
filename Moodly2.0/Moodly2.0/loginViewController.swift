//
//  loginViewController.swift
//  Moodly2.0
//
//  Created by Now chill bubu on 05/11/2020.
//

import UIKit

class loginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Cancel button tapped")
                
                self.dismiss(animated: true, completion: nil)
    
    }
}
