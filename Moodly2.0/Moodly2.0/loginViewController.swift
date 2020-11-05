//
//  loginViewController.swift
//  Moodly2.0
//
//  Created by Now chill bubu on 05/11/2020.
//

import UIKit
import Firebase

class loginViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
           if error == nil{
             self.performSegue(withIdentifier: "loginToHome", sender: self)
                          }
            else{
             let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
             let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
              alertController.addAction(defaultAction)
              self.present(alertController, animated: true, completion: nil)
                 }
        }
    }
    

    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Cancel button tapped")
                
                self.dismiss(animated: true, completion: nil)
    
    }
}
