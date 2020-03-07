//
//  CommentTableViewCell.swift
//  FITogram
//
//  Created by Pacek on 21/04/2019.
//

import UIKit

class CommentTableViewCell: UITableViewCell, NibNameIdentifiable {

    struct Input {
        let avatar: UIImage
        let username: String
        let comment: String
    }

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var commentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }

    func configure(with input: Input) {
        let username = NSAttributedString(string: input.username, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: .semibold)])
        let comment = NSAttributedString(string: " \(input.comment)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: .regular)])
        let attributedText = NSMutableAttributedString()
        attributedText.append(username)
        attributedText.append(comment)
        commentLabel.attributedText = attributedText
        avatarImageView.image = input.avatar
    }
    
}

extension CommentTableViewCell {

    func configure(with viewModel: CommentViewModeling) {
        configure(with: CommentTableViewCell.Input(
            avatar: viewModel.author.avatar,
            username: viewModel.author.username,
            comment: viewModel.text
        ))
    }

}

private extension CommentTableViewCell {

    func setup() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.layer.masksToBounds = true
    }

}
