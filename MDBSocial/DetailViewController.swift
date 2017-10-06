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
    var interested: ColorButton!
    var numInterested: UILabel!
    var goBackButton: ColorButton!

    var numGoing: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.mdb_blue
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

        interested = ColorButton(frame: CGRect(x: 10, y: view.frame.height * 0.8, width: view.frame.width * 0.3 - 20, height: 30))
        interested.setTitle("Interested?", for: .normal)
        interested.setup()
        interested.addTarget(self, action: #selector(interest), for: .touchUpInside)
        self.view.addSubview(interested)
        
        numInterested = UILabel(frame: CGRect(x: view.frame.width * 0.4, y: view.frame.height * 0.8, width: view.frame.width * 0.5, height: 30))
        numInterested.text = String(describing: numGoing) + " people are interested."
        numInterested.textAlignment = .center
        view.addSubview(numInterested)
        
        goBackButton = ColorButton(frame: CGRect(x: 10, y: 20, width: view.frame.width * 0.1, height: view.frame.width * 0.1))
        goBackButton.setTitle("<-", for: .normal)
        goBackButton.addTarget(self, action: #selector(goBackButtonClicked), for: .touchUpInside)
        goBackButton.setup()
        self.view.addSubview(goBackButton)
    }
    
    func interest() {
        numGoing = numGoing + 1
        numInterested.text = String(describing: numGoing) + " people are interested."
        interested.isEnabled = false
    }
    
    func downloadImg() {
        social.getImage(withBlock: { profileImage in
            DispatchQueue.main.async {
                self.eventImage.image = (profileImage)
            }
        })
    }
    
    func goBackButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
