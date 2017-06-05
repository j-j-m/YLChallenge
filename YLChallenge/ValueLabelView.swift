//
//  ValueLabelView.swift
//  YLChallenge
//
//  Created by Jacob Martin on 6/4/17.
//  Copyright © 2017 Jacob Martin. All rights reserved.
//

import UIKit

class ValueLabelView: UIView {

    
    var value: Int = 0 {
        didSet {
            valueLabel.text = String(value)
            self.alpha = 0.0
            self.isHidden = false
            
            UIView.animate(withDuration: 1.0) { 
                self.alpha = 1.0
            }
        }
    }
    @IBOutlet var valueLabel: UILabel!
    

}
