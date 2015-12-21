//
//  CommentTableViewCell.swift
//  liftorum
//
//  Created by Voxy on 12/20/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var createdAtLabel: UILabel!
    @IBOutlet var commentTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    

}
