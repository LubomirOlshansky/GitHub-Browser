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

     let userProvider = MoyaProvider<NetworkService>()
    
    typealias loadPhotoDataCompletion = ([Users]) -> Void
    
    func dowloadUsers(searchText: String, completion: @escaping loadPhotoDataCompletion) {
        
        userProvider.request(.getUsers(name: searchText)) { (result) in
            
            switch result {
            case .success(let response):
                print(response)
                let users = try! JSONDecoder().decode([Users].self, from: response.data)
                let usersArray = users
                print(usersArray)
                completion(usersArray)
            case .failure(let error):
                print(error)
                }
            }
        
    }
    func downloadRepos(completion: @escaping () -> () ) {
        
        
        //        Alamofire.request(router.groupList()).responseData { response in
        //            guard let data = response.value else { return }
        //            let json = JSON(data: data)
        //            let groups = json["response"]["items"].array?.flatMap { Group(json: $0) } ?? []
        //            Realm.replaceAllObjectOfType(toNewObjects: groups)
        //            completion()
        //        }
    }
}
