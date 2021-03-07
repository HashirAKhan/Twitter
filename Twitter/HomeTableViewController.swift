//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Hashir Khan on 2/23/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    var tweetArray = [NSDictionary]()
    var numberOfTweet: Int!
    var numOfTweets = 20
    
    let myRefreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        getTweets()
        
        myRefreshControl.addTarget(self, action: #selector(getTweets), for: .valueChanged)
        self.tableView.refreshControl = myRefreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getTweets()
        print("Load Table")
    }
    
    @objc func getTweets(){
        self.numOfTweets = 20
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let tweetParams = ["count": 20]
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: tweetParams, success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
        }, failure: { (Error) in
            print("Error fetching Tweets")
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
    
    func loadMoreTweets(){
        self.numOfTweets = self.numOfTweets + 20
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let tweetParams = ["count": self.numberOfTweet]
        print(self.numOfTweets)
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: tweetParams, success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
        }, failure: { (Error) in
            print("Error fetching Tweets")
        })
    }

    @IBAction func logoutPress(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetViewCell
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        if let imageData = data{
            cell.userImage.image = UIImage(data: imageData)
        }
        
        cell.userName.text = user["name"] as? String
        cell.tweetText.text = tweetArray[indexPath.row]["text"] as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }
}
