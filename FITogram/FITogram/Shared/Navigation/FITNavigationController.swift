//
//  FITNavigationController.swift
//  FITogram
//
//  Created by Pacek on 20/04/2019.
//

import UIKit

class FITNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

}

private extension FITNavigationController {

    func setup() {
        navigationBar.tintColor = UIColor.primary
        navigationBar.isTranslucent = false
    }

}
