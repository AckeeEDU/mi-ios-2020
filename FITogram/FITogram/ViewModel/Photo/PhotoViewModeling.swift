//
//  PhotoViewModeling.swift
//  Mendelugram
//
//  Created by Pacek on 24/04/2019.
//

import UIKit

protocol PhotoViewModeling {

    var author: AuthorViewModeling { get }
    var likesCount: Int { get }
    var description: String { get }
    var locationName: String? { get }
    var photo: UIImage { get }

    func numberOfComments() -> Int
    func comment(at index: Int) -> CommentViewModeling

}

extension PhotoViewModeling {

    var title: String {
        return "\(author.username)'s photo"
    }

}
