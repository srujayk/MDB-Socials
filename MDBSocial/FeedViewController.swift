//
//  FeedViewController.swift
//  MDBSocial
//
//  Created by Srujay Korlakunta on 9/26/17.
//  Copyright © 2017 Srujay Korlakunta. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController {
    
    var socialCollectionView: UICollectionView!
    var posts: [Social] = []
    var auth = FIRAuth.auth()
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    var storage: FIRStorageReference = FIRStorage.storage().reference()
    var currentUser: User?
    var socialToPass: Social!
    var logoutButton: ColorButton!
    var newSocialButton: ColorButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchUser {
            self.fetchSocials() {
                self.setupCollectionView()
                self.setupButtons()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    func setupButtons() {
        
        logoutButton = ColorButton(frame: CGRect(x: 0.5 * view.frame.width + 90, y: 0.1 * view.frame.height, width: 0.25 * UIScreen.main.bounds.width - 10, height: 30))
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.setup()
        logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        self.view.addSubview(logoutButton)
        
        newSocialButton = ColorButton(frame: CGRect(x: 0.5 * view.frame.width + 80, y: 0.05 * view.frame.height, width: 0.25 * view.frame.width, height: 30))
        newSocialButton.setTitle("New Social", for: .normal)
        newSocialButton.setup()
        newSocialButton.addTarget(self, action: #selector(newPost), for: .touchUpInside)
        self.view.addSubview(newSocialButton)
    }
    
    func setupCollectionView() {
        let frame = CGRect(x: 10, y: 30, width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 20)
        let cvLayout = UICollectionViewFlowLayout()
        socialCollectionView = UICollectionView(frame: frame, collectionViewLayout: cvLayout)
        socialCollectionView.delegate = self
        socialCollectionView.dataSource = self
        socialCollectionView.register(SocialCollectionViewCell.self, forCellWithReuseIdentifier: "post")
        socialCollectionView.backgroundColor = UIColor.white
        view.addSubview(socialCollectionView)
    }
    
    func newPost() {
        performSegue(withIdentifier: "toNewSocialFromFeed", sender: self)
    }
    
    func logOut() {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsFromFeed" {
            let details = segue.destination as! DetailViewController
            details.social = socialToPass
            details.user = currentUser
        }
        
        if segue.identifier == "toNewSocialFromFeed" {
            let newSocial = segue.destination as! NewSocialViewController
            newSocial.host = currentUser
        }
    }
    
    func fetchSocials(withBlock: @escaping () -> ()) {
        ref.child("Posts").observe(.childAdded, with: { (snapshot) in
            let post = Social(id: snapshot.key, socialDict: snapshot.value as! [String : Any]?)
            self.posts.insert(post, at: 0)
            withBlock()
        })
    }
    
    func fetchUser(withBlock: @escaping () -> ()) {
        ref.child("Users").child((self.auth?.currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            let user = User(id: snapshot.key, userDict: snapshot.value as! [String : Any]?)
            self.currentUser = user
            withBlock()
        })
    }
}


extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = socialCollectionView.dequeueReusableCell(withReuseIdentifier: "post", for: indexPath) as! SocialCollectionViewCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()

        let socialInQuestion = posts[indexPath.row]

        cell.socialText.text = socialInQuestion.title
        cell.hostText.text = socialInQuestion.host
        cell.social = socialInQuestion
        
        return cell
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: socialCollectionView.bounds.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = socialCollectionView.cellForItem(at: indexPath) as! SocialCollectionViewCell
        socialToPass = cell.social
        performSegue(withIdentifier: "toDetailsFromFeed", sender: self)
    }
    
    
}
