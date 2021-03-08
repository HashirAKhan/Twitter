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
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    var isLiked: Bool = false
    var tweetID:Int = -1
    var isRetweeted: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLiked(liked:Bool){
        isLiked = liked
        if(isLiked){
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
        
    }
    
    func setRetweeted(retweeted: Bool){
        isRetweeted = retweeted
        if isRetweeted {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }

    @IBAction func likePress(_ sender: Any) {
        let toBeLiked = !isLiked
        if toBeLiked {
            TwitterAPICaller.client?.favoriteTweet(tweetID: self.tweetID, success: {
                self.setLiked(liked: true)
            }, failure: { (error) in
                print("Error Liking tweet: \(error)")
                print(self.tweetID)
            })
        } else {
            TwitterAPICaller.client?.unFavoriteTweet(tweetID: self.tweetID, success: {
                self.setLiked(liked: false)
            }, failure: { (error) in
                print("Error unliking tweet: \(error)")
            })
        }
    }
    @IBAction func retweetPress(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweeted(retweeted: true)
        }, failure: { (error) in
            print("error retweeting: \(error)")
        })
    }
}
