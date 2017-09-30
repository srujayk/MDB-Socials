//
//  SocialCollectionViewCell.swift
//  MDBSocial
//
//  Created by Srujay Korlakunta on 9/26/17.
//  Copyright © 2017 Srujay Korlakunta. All rights reserved.
//


import UIKit
import Firebase

class SocialCollectionViewCell: UICollectionViewCell {
    
    var social: Social!
    var profileImage: UIImageView!
    var hostText: UILabel!
    var socialText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red:0.45, green:0.74, blue:0.95, alpha:1.0)
        setupHostText()
        setupSocialText()
    }
    
    func setupHostText() {
        hostText = UILabel(frame: CGRect(x: 10, y: 50, width: self.frame.width, height: 20))
        hostText.font = UIFont.systemFont(ofSize: 15)
        hostText.adjustsFontForContentSizeCategory = true
        addSubview(hostText)
    }
    
    func setupSocialText() {
        socialText = UILabel(frame: CGRect(x: 10, y: 10, width: self.frame.width, height: 30))
        socialText.font = UIFont.systemFont(ofSize: 20)
        socialText.adjustsFontForContentSizeCategory = true
        addSubview(socialText)
    }
    
}
