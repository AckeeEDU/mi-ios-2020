//
//  PhotoCollectionViewCell.swift
//  FITogram
//
//  Created by Pacek on 21/04/2019.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell, NibNameIdentifiable {

    struct Input {
        let photo: UIImage
    }

    @IBOutlet private weak var photoImageView: UIImageView!

    func configure(with input: Input) {
        photoImageView.image = input.photo
    }

}
