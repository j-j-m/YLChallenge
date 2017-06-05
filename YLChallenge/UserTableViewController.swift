//
//  UserTableViewController.swift
//  YLChallenge
//
//  Created by Jacob Martin on 6/4/17.
//  Copyright © 2017 Jacob Martin. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    var follower: Follower? {
        didSet {
            if let f = follower {
                
             
                if let url = f.avatarURL {
                    self.headerView.userLogin = f.login
                    WebService.shared.retrieveAvatarFromUrl(url, completion: { [weak self] (image) in
                        DispatchQueue.main.async {
                            self?.headerView.avatarImage = image
                        }
                    })
                    
                    WebService.shared.getUserData(user: f.login, completion: { [weak self] (user)  in
                        DispatchQueue.main.async {
                            self?.headerView.setupUser(user: user)
                            
                            if let location = user.location {
                                self?.locationLabel.text = "Location: \(location)"
                            }
                            else {
                                self?.locationLabel.text = "No location provided..."
                            }
                            
                            if let email = user.email {
                                self?.emailLabel.text = "Email: \(email)"
                            }
                            else {
                                self?.emailLabel.text = "No email provided..."
                            }
                        }
                    })
                }
            }
        }
    }
    var user: User? // the follower has become the user. ommmmm.
    
    var headerView: UserHeaderView = UserHeaderView.instanceFromNib()
    
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableHeaderView = headerView
        
        
        self.tableView.contentInset = UIEdgeInsetsMake(-64,0,0,0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
}
