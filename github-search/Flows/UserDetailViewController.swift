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
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var userName: UILabel! {
        didSet {
            userName.layer.cornerRadius = 5
            userName.layer.masksToBounds = true
        }
    }
    
    
    let userDetailService = UserDetailService()
    var user: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userName.text = self.user
        userDetailService.loadUserDetail(name: self.user) { [weak self]
            responce in
            print(responce)
            self?.followers.text = String(responce.1)
            if let imageURL = URL(string: responce.0) {
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
        userDetailService.loadUserRepos(name: self.user) { [weak self]
            responce in
            var starsCount = 0
            for repo in responce {
                starsCount += repo.stargazers_count
            }
            self?.stars.text = String(starsCount)
        
        }
    }
}
