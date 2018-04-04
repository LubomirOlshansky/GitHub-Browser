//
//  NetworkService.swift
//  github-search
//
//  Created by Lubomir Olshansky on 02/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import Foundation
import Moya

enum  NetworkService {
    case getUsers(userName: String)
    case getRepos(repoName: String)
    case getUserRep(id: String)
}

extension NetworkService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .getUsers(_):
            return "/search/users"
            
        case .getRepos(_):
            return "/search/repositories"
            
        case .getUserRep(let id):
            return "/users/\(id)/repos"
            
        }
    }
    
    var method: Moya.Method {
            return .get
      
    }
    
    var sampleData: Data {
        switch self {
        case .getRepos(_), .getUsers(_), .getUserRep(_):
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .getUsers(let userName), .getRepos(let userName):
            return .requestParameters(parameters: ["q": userName, "client_id": "626f0b85d71143696356", "client_secret": "44f0947801043cc0f372ec572c35f944ead64ed9", "per_page": "5"],  encoding: URLEncoding.default)
            
        case .getUserRep(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Typer": "application/json"]
        }
}
