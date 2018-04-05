//
//  Base.swift
//  github-search
//
//  Created by Lubomir Olshansky on 05/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import Foundation

struct Base {
    var id: Int
    var name: String
    var isUser: Bool
    init(repo: Repo) {
        id = repo.id
        name = repo.name
        isUser = false
    }
    init(user: User) {
        id = user.id
        name = user.login
        isUser = true
    }
}
