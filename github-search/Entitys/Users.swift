//
//  Users.swift
//  github-search
//
//  Created by Lubomir Olshansky on 02/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

struct Users: Decodable {
    var id: Int
    var name: String
    var followers: Int
}
