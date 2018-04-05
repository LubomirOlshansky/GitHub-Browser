//
//  UserDetailViewController.swift
//  github-search
//
//  Created by Lubomir Olshansky on 05/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var userPhoto: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var stars: UILabel!
    
    var user: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = user
        
    }

}
