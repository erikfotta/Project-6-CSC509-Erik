//
//  MainToDoTableViewCell.swift
//  To Do App v1
//
//  Created by Erik Fotta on 1/16/20.
//  Copyright © 2020 Erik Fotta. All rights reserved.
//

import UIKit
import Foundation

class MainToDoTableViewCell: UITableViewCell {

    // Declare outlet variabls
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var deadlinesLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        }

}
