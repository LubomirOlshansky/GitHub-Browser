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
    case getUserRep(name: String)
    case getUserInfo(userName: String)
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
            
        case .getUserRep(let name):
            return "/users/\(name)/repos"
            
        case .getUserInfo(let name):
            return "/users/\(name)"
        }
    }
    
    var method: Moya.Method {
            return .get
    }
    
    var sampleData: Data {
        switch self {
        case .getUsers(let userName):
             return "{'name':'\(userName)'}".utf8Encoded
        case .getRepos(let getRepos):
            return "{'name':'\(getRepos)'}".utf8Encoded
        case .getUserRep(let name):
              return "{'name':'\(name)'}".utf8Encoded
        case .getUserInfo(let userName):
           return "{'name':'\(userName)'}".utf8Encoded
        
        
        }
    }
    
    //For unauthenticated requests, the rate limit allows to make only 10 requests per minute, with client_id/client_secret - up to 30
    var task: Task {
        switch self {
        case .getUsers(let userName), .getRepos(let userName):
            let parameters = [
                "q": userName,
                "client_id": Environment.clientID,
                "client_secret": Environment.clientSecret,
                "per_page": "10"
            ]
            
            return .requestParameters(parameters: parameters,  encoding: URLEncoding.default)
            
        case .getUserRep(_), .getUserInfo(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Typer": "application/json"]
        }
}
private extension String {

    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
