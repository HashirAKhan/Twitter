//
//  tweetViewCell.swift
//  Twitter
//
//  Created by Hashir Khan on 2/23/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
