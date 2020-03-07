//
//  CommentViewModeling.swift
//  Mendelugram
//
//  Created by Pacek on 24/04/2019.
//

import Foundation

protocol CommentViewModeling {

    var author: AuthorViewModeling { get }
    var text: String { get }

}
