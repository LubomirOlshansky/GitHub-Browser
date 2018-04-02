//
//  Environment.swift
//  github-search
//
//  Created by Lubomir Olshansky on 02/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import Foundation

protocol Environment {
    
    var client_id: String { get }
    var client_secret: String { get }
}
