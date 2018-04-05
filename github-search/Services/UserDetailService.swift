//
//  UserDetailService.swift
//  github-search
//
//  Created by Lubomir Olshansky on 05/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit
import Moya

class UserDetailService: UIViewController {

     let userProvider = MoyaProvider<NetworkService>()
    typealias loadUserDetailDataComplition = ((String, Int)) -> Void
    typealias loadUserReposDataComplition = ([UserRepos]) -> Void
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func loadUserDetail(name: String, completion: @escaping loadUserDetailDataComplition) {
       
        userProvider.request(.getUserInfo(userName: name)) { (result) in
            
            switch result {
            case .success(let response):
//                                let data = response.data
//                                let statusCode = response.statusCode
//                                print(data)
//                                print(statusCode)
                
                guard let userDetail = try? JSONDecoder().decode(UserDetail.self, from: response.data) else { return }
//                print("data delivered")
                 DispatchQueue.main.async {
                    completion((userDetail.avatar_url, userDetail.followers))
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    func loadUserRepos(name: String, completion: @escaping loadUserReposDataComplition) {
        
        //fix id to name
        userProvider.request(.getUserRep(id: name)) { (result) in
            
            switch result {
            case .success(let response):
                let data = response.data
                let statusCode = response.statusCode
                print(data)
                print(statusCode)
                
                guard let userReposiroties = try? JSONDecoder().decode([UserRepos].self, from: response.data) else { return }
                print("data delivered")
                DispatchQueue.main.async {
                    completion(userReposiroties)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
