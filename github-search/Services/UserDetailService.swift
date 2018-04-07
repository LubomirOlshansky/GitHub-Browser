//
//  UserDetailService.swift
//  github-search
//
//  Created by Lubomir Olshansky on 05/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit
import Moya

struct UserDetailService {

    private let provider: MoyaProvider<NetworkService>
        
    typealias loadUserDetailDataComplition = ((String, Int)) -> Void
    typealias loadUserReposDataComplition = ([UserRepos]) -> Void
    
        init(provider: MoyaProvider<NetworkService> = MoyaProvider<NetworkService>()) {
            self.provider = provider
        }

    
    func loadUserDetail(name: String, completion: @escaping loadUserDetailDataComplition) {
       
        provider.request(.getUserInfo(userName: name)) { (result) in
            
            switch result {
            case .success(let response):
                
                guard let userDetail = try? JSONDecoder().decode(UserDetail.self, from: response.data) else { return }
                
                print(userDetail)
                 DispatchQueue.main.async {
                    completion((userDetail.avatar_url, userDetail.followers))
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadUserRepos(name: String, completion: @escaping loadUserReposDataComplition) {
        
        provider.request(.getUserRep(name: name)) { (result) in
            
            switch result {
            case .success(let response):

                
                guard let userReposiroties = try? JSONDecoder().decode([UserRepos].self, from: response.data) else { return }

                DispatchQueue.main.async {
                    completion(userReposiroties)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
