//
//  SearchService.swift
//  github-search
//
//  Created by Lubomir Olshansky on 02/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import Foundation
import Moya

struct SearchService {

    private let provider: MoyaProvider<NetworkService>
    let dispatchGroup = DispatchGroup()
    typealias loadRepositoriesDataComplition = ([Repo]) -> Void
    typealias loadUsersDataComplition = ([User]) -> Void
    typealias loadUsersAndReposDataComplition = ([Base]) -> Void
    
    
    //init with a default parameter to specify a different provider when testing.
    init(provider: MoyaProvider<NetworkService> = MoyaProvider<NetworkService>()) {
        self.provider = provider
    }
    
    func loadRepositories(name: String, completion: @escaping loadRepositoriesDataComplition) {
        dispatchGroup.enter()
        provider.request(.getRepos(repoName: name)) { (result) in
        
            switch result {
            case .success(let response):

                guard let repositories = try? JSONDecoder().decode(Repositories.self, from: response.data) else { return }

                completion(repositories.items)
                self.dispatchGroup.leave()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    func loadUsers(name: String, completion: @escaping loadUsersDataComplition) {
          dispatchGroup.enter()
        provider.request(.getUsers(userName: name)) { (result) in
            switch result {
            case .success(let response):
                
                guard let users = try? JSONDecoder().decode(Users.self, from: response.data) else { return }
                
                completion(users.items)
                self.dispatchGroup.leave()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadUsersAndRepos(name: String, completion: @escaping loadUsersAndReposDataComplition) {
        var searchResponce = [Base]()
            self.loadRepositories(name: name) {
            responce in
            responce.forEach {
                searchResponce.append(Base(repo: $0))
                }
        }
            self.loadUsers(name: name) {
            responce in
            responce.forEach {
                searchResponce.append(Base(user: $0))
                }
        }
  
    //chain asynchronous operations callbacks with dispatchGroup
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion(searchResponce)
        }
    }
}
