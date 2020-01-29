//
//  PointsViewController.swift
//  To Do App v1
//
//  Created by Erik Fotta on 1/24/20.
//  Copyright © 2020 Erik Fotta. All rights reserved.
//

import UIKit
import Foundation

class PointsViewController: UIViewController {

    // Declare Outler Variables
    @IBOutlet weak var totalPointsLabel: UILabel!
    @IBOutlet weak var imageEntry: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    
    // Declare Variables
    var defaults = UserDefaults.standard
    var totalPoints: Int = 0
    let bronze = UIImage(named: "Bronze")
    let silver = UIImage(named: "Silver")
    let gold = UIImage(named: "Gold")
    let platinum = UIImage(named: "Platinum")
    let master = UIImage(named: "Master")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Points from UserDefaults
        if let points = defaults.integer(forKey: "totalPoints") as Int? {
                totalPoints = points
        }
        // Update points label
        totalPointsLabel.text = "\(totalPoints)"
        // Create ranks, image and label
        if totalPoints < 100 {
            imageEntry.image = bronze
            rankLabel.text = "Bronze"
        } else if totalPoints < 400 {
            imageEntry.image = silver
            rankLabel.text = "Silver"
        } else if totalPoints < 1000 {
            imageEntry.image = gold
            rankLabel.text = "Gold"
        } else if totalPoints < 2500 {
            imageEntry.image = platinum
            rankLabel.text = "Platinum"
        } else  {
            imageEntry.image = master
            rankLabel.text = "Master"
        }
    }
    // Refresh the page for new values from UserDefaults when view appears
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
}
