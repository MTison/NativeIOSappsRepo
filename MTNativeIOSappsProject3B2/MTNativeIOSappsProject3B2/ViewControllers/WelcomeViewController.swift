//
//  WelcomeViewController.swift
//  MTNativeIOSappsProject3B2
//
//  Created by Matthias Tison on 31/12/2017.
//  Copyright © 2017 Matthias Tison. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var welcomeLabelText: UILabel!
    
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        let decoded = userDefaults.object(forKey:"loggedUser") as! Data
        let loggedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! User
        
        welcomeLabelText.text = "Welcome \(loggedUser.adressingName), glad you are using the application!"
    }
}
