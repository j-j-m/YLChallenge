//
//  UserHeaderView.swift
//  YLChallenge
//
//  Created by Jacob Martin on 6/4/17.
//  Copyright © 2017 Jacob Martin. All rights reserved.
//

import UIKit

class UserHeaderView: UITableViewHeaderFooterView {
    
    var userLogin: String? {
        didSet {
            loginLabel.text = userLogin!
        }
    }
    
    var avatarImage: UIImage? {
        didSet {
            if let image = avatarImage {
                backgroundImageView.image = image
                avatar.image = image
            }
        }
    }
    
    
    
    @IBOutlet var backgroundImageView:UIImageView!
    @IBOutlet var avatar:AvatarImageView!
    
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var followerLabel: ValueLabelView!
    @IBOutlet var followingLabel: ValueLabelView!
    @IBOutlet var repoLabel: ValueLabelView!
    
    
    class func instanceFromNib() -> UserHeaderView {
        return UINib(nibName: "UserHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UserHeaderView
    }
    
    
    func setupUser(user: User){
        nameLabel.text = user.name
        nameLabel.alpha = 0
        nameLabel.isHidden = false
        
        followerLabel.value = user.followers
        followingLabel.value = user.following
        repoLabel.value = user.publicRepos
        
        UIView.animate(withDuration: 1.0) { 
            self.nameLabel.alpha = 1.0
        }
    }

}
