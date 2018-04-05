//
//  UserDetail.swift
//  github-search
//
//  Created by Lubomir Olshansky on 05/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import Foundation

struct UserDetail: Decodable {
    var followers: Int
    var avatar_url: String
}
