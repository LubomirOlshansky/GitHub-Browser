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
    
    
    let userDetailService = UserDetailService()
    var user: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = user
        userDetailService.loadUserDetail(name: "mojombo") { [weak self]
            responce in
            print(responce)
            self?.followers.text = String(responce.1)
            if let imageURL = URL(string: responce.0
                
                ) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self?.userPhoto.image = image
                        }
                    }
                }
            }
        }
    }

}
