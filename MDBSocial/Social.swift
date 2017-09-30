//
//  Social.swift
//  
//  Created by Srujay Korlakunta on 9/26/17.
//  Copyright © 2017 Srujay Korlakunta. All rights reserved.
//

import Foundation
import Firebase

class Social {
    var socialText: String?
    var imageUrl: String?
    var host: String?
    var id: String?
    var hostId: String?
    var image: UIImage?
    var title: String?
    var date: String?
 
    init(id: String, socialDict: [String:Any]?) {
        self.id = id
        
        if let title = socialDict?["title"] as? String {
            self.title = title
        }
        if let host = socialDict!["poster"] as? String {
            self.host = host
        }
        if let hostId = socialDict?["posterId"] as? String {
            self.hostId = hostId
        }
        if let date = socialDict?["date"] as? String {
            self.date = date
        }
        if let socialText = socialDict!["text"] as? String {
            self.socialText = socialText
        }
        if let imageUrl = socialDict!["imageURL"] as? String {
            self.imageUrl = imageUrl
        }

    }
    
    func getImage(withBlock: @escaping (_ profileImage: UIImage) -> ()) {
        let ref = FIRStorage.storage().reference(forURL: imageUrl!)
        ref.data(withMaxSize: 1 * 2048 * 2048) { data, error in
            if let error = error {
                print(error)
            } else {
                withBlock(UIImage(data: data!)!)
            }
        }
    }
    
    init() {}

}
