//
//  LiftTableViewCell.swift
//  liftorum
//
//  Created by Voxy on 11/14/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit

class LiftTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
