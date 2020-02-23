//
//  ViewController.swift
//  Instagram
//
//  Created by Jan Misar on 23/02/2020.
//  Copyright © 2020 ČVUT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var buildNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            versionLabel.text = L10n.Main.versionLabel(version)
            buildNumberLabel.text = L10n.Main.buildNumberLabel(buildNumber)
        }
    }


}

