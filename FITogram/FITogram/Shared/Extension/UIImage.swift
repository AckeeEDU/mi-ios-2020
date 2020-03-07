//
//  UIImage.swift
//  FITogram
//
//  Created by Pacek on 21/04/2019.
//

import UIKit

extension UIImage {

    convenience init(photoId: String) {
        self.init(named: "photo-\(photoId)")!
    }

    convenience init(avatarId: String) {
        self.init(named: "avatar-\(avatarId)")!
    }

}
