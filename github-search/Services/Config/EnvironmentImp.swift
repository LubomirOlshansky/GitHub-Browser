//
//  EnvironmentImp.swift
//  github-search
//
//  Created by Lubomir Olshansky on 02/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import Foundation

struct EnvironmentImp {
    private init(){}
}

extension EnvironmentImp {
    
    struct Debug: Environment {
        var client_id = "626f0b85d71143696356"
        var client_secret = "44f0947801043cc0f372ec572c35f944ead64ed9"
    }
    
}
