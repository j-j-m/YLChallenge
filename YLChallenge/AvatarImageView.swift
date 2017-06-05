//
//  AvatarImageView.swift
//  YLChallenge
//
//  Created by Jacob Martin on 6/4/17.
//  Copyright © 2017 Jacob Martin. All rights reserved.
//

import UIKit

@IBDesignable class AvatarImageView: UIImageView {

    
    /// corner radius for view
    @IBInspectable var cornerRadius: CGFloat = 50.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    /// fade for transition
    @IBInspectable var fadeDuration: Double = 0.13
    
    /// when setting image we should transition to the new image
    override var image: UIImage? {
        get {
            return super.image
        }
        set(newImage) {
            if let img = newImage {
                CATransaction.begin()
                CATransaction.setAnimationDuration(self.fadeDuration)
                
                let transition = CATransition()
                transition.type = kCATransitionFade
                
                super.layer.add(transition, forKey: kCATransition)
                super.image = img
                
                CATransaction.commit()
            } else {
                super.image = nil
            }
        }
    }
}
