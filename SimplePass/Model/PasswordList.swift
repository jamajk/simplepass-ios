//
//  PasswordList.swift
//  SimplePass
//
//  Created by Jakub Majkowski on 08/01/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import Foundation

class PasswordList {
    var list: [Password] = []
    var count = 0
    
    func addPassword(name: String, user: String, password: String) {
        list.append(Password(name: name, user: user, password: password))
        count += 1
    }
}


