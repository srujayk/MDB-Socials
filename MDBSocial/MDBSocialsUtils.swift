//
//  MDBSocialsUtils.swift
//  MDBSocial
//
//  Created by Srujay Korlakunta on 10/6/17.
//  Copyright © 2017 Srujay Korlakunta. All rights reserved.
//

import Foundation
import UIKit

class ColorButton: UIButton {
    func setup() {
        backgroundColor = Constants.mdb_yellow
        layer.cornerRadius = Constants.corner_radius
        setTitleColor(.white, for: .normal)
        layer.masksToBounds = true
        layoutIfNeeded()
    }
}
