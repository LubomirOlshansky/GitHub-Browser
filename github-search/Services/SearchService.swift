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
    
    
    typealias loadRepositoriesDataComplition = ([Base]) -> Void
    
    
    
    func loadRepositories(name: String, completion: @escaping loadRepositoriesDataComplition) {
        userProvider.request(.getRepos(repoName: name)) { (result) in
            switch result {
            case .success(let response):
                let data = response.data
                let statusCode = response.statusCode
                print(data)
                print(statusCode)
                
                let repositories = try! JSONDecoder().decode(Repositories.self, from: response.data)
                print("data delivered")
                let repositoriesConverted = repositories.items
                var base = [Base]()
                repositoriesConverted.forEach {
                    base.append(Base(repo: $0))
                }
                completion(base)
                
                
            case .failure(let error):
                print(error)
            }
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
