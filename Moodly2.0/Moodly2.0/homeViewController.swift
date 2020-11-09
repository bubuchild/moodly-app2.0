//
//  homeViewController.swift
//  Moodly2.0
//
//  Created by Now chill bubu on 09/11/2020.
//

import UIKit

class homeViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateStyle = .medium
        
        //formatter.dateFormat = "MM/dd/yyyy"
        
        dateLabel.text = formatter.string(from: date)
        // Do any additional setup after loading the view.
    }
}
