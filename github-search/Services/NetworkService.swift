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
    case getUsers(name: String)
    case getRepos(name: String)
    case getUserRep(id: String)
}

extension NetworkService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .getUsers(_):
            return "search/users"
            
        case .getRepos(_):
            return "/search/epositories"
            
        case .getUserRep(let id):
            return "/users/\(id)/repos"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRepos(_), .getUsers(_), .getUserRep(_):
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getRepos(_), .getUsers(_), .getUserRep(_):
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .getUsers(let name), .getRepos(let name):
            return .requestParameters(parameters: ["q" : name], encoding: JSONEncoding.default)
            
        case .getUserRep(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Typer": "application/json"]
        }
}
