//
//  signupViewController.swift
//  Moodly2.0
//
//  Created by Now chill bubu on 05/11/2020.
//

import UIKit

class signupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    
    @IBAction func singupCancelButtonTapped(_ sender: Any) {
        print("Cancel button tapped")
                
                self.dismiss(animated: true, completion: nil)
    }
    
}
