//
//  PhotoViewModel.swift
//  Mendelugram
//
//  Created by Pacek on 24/04/2019.
//

import UIKit

struct PhotoViewModel: PhotoViewModeling {

    var author: AuthorViewModeling {
        return model.author
    }

    var likesCount: Int {
        return model.likesCount
    }

    var description: String {
        return model.description
    }

    var locationName: String? {
        return model.locationName
    }

    var photo: UIImage {
        return UIImage(photoId: model.photoId)
    }

    func numberOfComments() -> Int {
        return model.comments.count
    }

    func comment(at index: Int) -> CommentViewModeling {
        return CommentViewModel(comment: model.comments[index])
    }

    let model: Photo

}
