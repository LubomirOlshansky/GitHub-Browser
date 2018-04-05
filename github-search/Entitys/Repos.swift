//
//  Repos.swift
//  github-search
//
//  Created by Lubomir Olshansky on 05/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import Foundation

struct Repositories: Decodable {
    var items: [Repo]
}
struct Repo: Decodable {
    var name: String
    var id: Int
}
