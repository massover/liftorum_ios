//
//  LiftTableViewCell.swift
//  liftorum
//
//  Created by Voxy on 11/14/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit


class LiftTableViewCell: UITableViewCell{
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet var newCommentButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}


