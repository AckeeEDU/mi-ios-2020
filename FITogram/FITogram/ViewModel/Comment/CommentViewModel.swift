//
//  CommentViewModel.swift
//  Mendelugram
//
//  Created by Pacek on 24/04/2019.
//

import UIKit

struct CommentViewModel: CommentViewModeling {

    var author: AuthorViewModeling {
        return comment.author
    }

    var text: String {
        return comment.text
    }

    let comment: Comment

}
