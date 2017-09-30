//
//  DetailViewController.swift
//  MDBSocial
//
//  Created by Srujay Korlakunta on 9/26/17.
//  Copyright © 2017 Srujay Korlakunta. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    
    var social: Social!
    var user: User!
    
    var eventTitle: UILabel!
    var eventDate: UILabel!
    var hostName: UILabel!
    var eventImage: UIImageView!
    var eventDesc: UILabel!
    var interested: UIButton!
    var numInterested: UILabel!
    var goBackButton: UIButton!

    var numGoing: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.45, green:0.74, blue:0.95, alpha:1.0)
        setupSocialDetails()
    }
    
    func setupSocialDetails() {
        
        eventTitle = UILabel(frame: CGRect(x:0, y: view.frame.height * 0.1, width: view.frame.width * 1, height: 50))
        eventTitle.font = UIFont.systemFont(ofSize: 30, weight: 2)
        eventTitle.text = social.title
        eventTitle.textAlignment = .center
        view.addSubview(eventTitle)
        
        eventDate = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.2, width: view.frame.width * 0.5, height: 20))
        eventDate.text = social.date
        eventDate.textAlignment = .center
        view.addSubview(eventDate)
        
        hostName = UILabel(frame: CGRect(x: view.frame.width * 0.5, y: view.frame.height * 0.2, width: view.frame.width * 0.5, height: 20))
        hostName.text = social.host
        hostName.textAlignment = .center
        view.addSubview(hostName)
        
        eventImage = UIImageView(frame: CGRect(x: 10, y: view.frame.width * 0.3, width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width - 20))
        eventImage.contentMode = .scaleAspectFit
        view.addSubview(eventImage)
        downloadImg()
        
        eventDesc = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.65, width: view.frame.width * 1, height: 30))
        eventDesc.text = social.socialText
        eventDesc.textAlignment = .center
        view.addSubview(eventDesc)

        interested = UIButton(frame: CGRect(x: 10, y: view.frame.height * 0.8, width: view.frame.width * 0.3 - 20, height: 30))
        interested.layoutIfNeeded()
        interested.setTitle("Interested?", for: .normal)
        interested.setTitleColor(UIColor.blue, for: .normal)
        interested.layer.cornerRadius = 3.0
        interested.backgroundColor = UIColor(red:0.98, green:0.86, blue:0.36, alpha:1.0)
        interested.setTitleColor(.white, for: .normal)
        interested.layer.masksToBounds = true
        interested.addTarget(self, action: #selector(interest), for: .touchUpInside)
        self.view.addSubview(interested)
        
        numInterested = UILabel(frame: CGRect(x: view.frame.width * 0.4, y: view.frame.height * 0.8, width: view.frame.width * 0.5, height: 30))
        numInterested.text = String(describing: numGoing) + " people are interested."
        numInterested.textAlignment = .center
        view.addSubview(numInterested)
        
        goBackButton = UIButton(frame: CGRect(x: 10, y: 20, width: view.frame.width * 0.1, height: view.frame.width * 0.1))
        goBackButton.layoutIfNeeded()
        goBackButton.setTitle("<-", for: .normal)
        goBackButton.setTitleColor(UIColor.blue, for: .normal)
        goBackButton.layer.cornerRadius = 3.0
        goBackButton.backgroundColor = UIColor(red:0.98, green:0.86, blue:0.36, alpha:1.0)
        goBackButton.setTitleColor(.white, for: .normal)
        goBackButton.layer.masksToBounds = true
        goBackButton.addTarget(self, action: #selector(goBackButtonClicked), for: .touchUpInside)
        self.view.addSubview(goBackButton)
    }
    
    func interest() {
        numGoing = numGoing + 1
        numInterested.text = String(describing: numGoing) + " people are interested."
    }
    
    func downloadImg() {
        social.getImage(withBlock: { profileImage in
            self.eventImage.image = (profileImage)
        })
    }
    
    func goBackButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
