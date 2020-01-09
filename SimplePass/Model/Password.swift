//
//  PasswordList.swift
//  SimplePass
//
//  Created by Jakub Majkowski on 22/12/2019.
//  Copyright © 2019 Jakub Majkowski. All rights reserved.
//

import Foundation

struct Password {
    var name: String
    var username: String
    var password: String
}

extension Password {
    init() {
        self.name = "defaultName"
        self.username = "defaultUsername"
        self.password = "defaultPassword"
    }
    
    init(name: String, user: String, password: String) {
        self.name = name
        self.username = user
        self.password = password
    }
}
