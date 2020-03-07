//
//  FITNavigationItem.swift
//  FITogram
//
//  Created by Pacek on 20/04/2019.
//

import UIKit

class FITNavigationItem: UINavigationItem {

    override init(title: String) {
        super.init(title: title)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func configure() {
        let image = UIImageView(image: #imageLiteral(resourceName: "logo.pdf"), highlightedImage: nil)
        image.contentMode = .scaleAspectFit
        titleView = image
    }

}
