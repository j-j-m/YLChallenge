//
//  FollowerCollectionViewCell.swift
//  YLChallenge
//
//  Created by Jacob Martin on 6/4/17.
//  Copyright © 2017 Jacob Martin. All rights reserved.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: AvatarImageView!
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        imageView.image = UIImage.defaultAvatar()
    }
    
    /// set and animate label with follower data
    ///
    /// - Parameter follower: follower with data for label
    func setFollower(_ follower: Follower) {

        self.label.text = follower.login
        self.label.alpha = 0.0
        self.label.isHidden = false
        UIView.animate(withDuration: 1.0, animations: {
            self.label.alpha = 1.0
        })
    }
}
