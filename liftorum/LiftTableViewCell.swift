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
    


    @IBOutlet weak var commentCollectionView: CommentCollectionView!
    @IBOutlet weak var newCommentText: UITextField!
    @IBOutlet weak var newCommentSubmitButton: UIButton!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


