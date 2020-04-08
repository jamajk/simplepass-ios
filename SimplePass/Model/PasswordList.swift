//
//  PasswordList.swift
//  SimplePass
//
//  Created by Jakub Majkowski on 08/01/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import Foundation
import KeychainAccess

class PasswordList {
    var list: [Password] = []
    var count = 0
    
    let keychain = Keychain(service: "com.jamajk.simplepass")
    
    func addPassword(name: String, user: String, password: String) {
        list.append(Password(name: name, user: user, password: password))
        count += 1
        encode()
    }
    
    func deletePassword(index: Int) {
        list.remove(at: index)
        count -= 1
        encode()
    }
    
    func editPassword(index: Int, password: Password) {
        list.remove(at: index)
        list.insert(password, at: index)
        encode()
    }
    
    func decode() {
        
        if let token = keychain["simplepass"] {
            let decoder = JSONDecoder()
            do{
                if let data: Data = token.data(using: .utf8) {
                    list = try decoder.decode([Password].self, from: data)
                    count = list.count
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func encode() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let jsonData = try encoder.encode(list)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                try keychain.set(jsonString, key: "simplepass")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}


