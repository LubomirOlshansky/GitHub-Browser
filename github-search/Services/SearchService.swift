//
//  SearchService.swift
//  github-search
//
//  Created by Lubomir Olshansky on 02/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import Foundation
import Moya

class SearchService: UIViewController {

    let userProvider = MoyaProvider<NetworkService>()
    
//    var repos1 =  [Repo]()
//    var users1 = [User]()
    let dispatchGroup = DispatchGroup()
    typealias loadRepositoriesDataComplition = ([Repo]) -> Void
    typealias loadUsersDataComplition = ([User]) -> Void
    typealias loadUsersAndReposDataComplition = ([Base]) -> Void
    
    
    
    func loadRepositories(name: String, completion: @escaping loadRepositoriesDataComplition) {
        dispatchGroup.enter()
        userProvider.request(.getRepos(repoName: name)) { (result) in
        
            switch result {
            case .success(let response):
//                let data = response.data
//                let statusCode = response.statusCode
//                print(data)
//                print(statusCode)

                guard let repositories = try? JSONDecoder().decode(Repositories.self, from: response.data) else { return }
                print("data delivered")

//                var base = [Base]()
//                repositoriesConverted.forEach {
//                    base.append(Base(repo: $0))
//                }
                completion(repositories.items)
                self.dispatchGroup.leave()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    func loadUsers(name: String, completion: @escaping loadUsersDataComplition) {
          dispatchGroup.enter()
        userProvider.request(.getUsers(userName: name)) { (result) in
            switch result {
            case .success(let response):
//                let data = response.data
//                let statusCode = response.statusCode
//                print(data)
//                print(statusCode)
                
                guard let users = try? JSONDecoder().decode(Users.self, from: response.data) else { return }
                print("data delivered")
//                var base1 = [Base]()
//                usersConverted.forEach {
//                    base1.append(Base(user: $0))
//                }
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
  
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion(searchResponce)
            print("notify")
    }
}
    
    
    
    
//    func loadPhotoData(name: String, completion: @escaping loadPhotoDataCompletion) {
//        
//        let path = "/search/users"
//        let parameters: Parameters = [
//            "q": name,
//            ]
//        let url = baseUrl+path
//        
//        Alamofire.request(url, method: .get, parameters: parameters).responseJSON(queue: .global(qos: .userInteractive))
//        { responce in
//
//            guard let data = responce.data else { return }
//                var statusCode = response.response?.statusCode
//            
//            do {
//                print(data)
//                let orderDecoded = try JSONDecoder().decode(Users.self, from: data)
////                print(orderDecoded.items[0].login)
//                print(orderDecoded)
//                DispatchQueue.main.async {
//                    completion([orderDecoded])
//                    return
//                }
//            } catch let jsonErr {
//                print(data)
//                print("Error serializing json:", jsonErr)
//            }
//        }
//        
        
        
        

}
