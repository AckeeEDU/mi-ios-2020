//
//  MainTabBarViewController.swift
//  FITogram
//
//  Created by Pacek on 20/04/2019.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

}

private extension MainTabBarViewController {

    func setup() {
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.primary
    }

}
