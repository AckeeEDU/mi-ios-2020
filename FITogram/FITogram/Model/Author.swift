//
//  Author.swift
//  FITogram
//
//  Created by Pacek on 20/04/2019.
//

import UIKit

struct Author {

    let username: String
    let name: String
    let avatarId: String

}

extension Author: AuthorViewModeling {

    var avatar: UIImage {
        return UIImage(avatarId: avatarId)
    }

}
