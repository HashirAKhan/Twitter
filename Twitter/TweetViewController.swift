//
//  TweetViewController.swift
//  Twitter
//
//  Created by Hashir Khan on 3/5/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tweetPress(_ sender: Any) {
        if (!textField.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: textField.text, success: {
                print("tweet success")
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
