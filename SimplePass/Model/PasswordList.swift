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
        encode()
    }
    
    func deletePassword(index: Int) {
        list.remove(at: index)
        count -= 1
        encode()
    }
    
    func decode() {
        guard let url = Bundle.main.url(forResource: "passwordlist", withExtension: "json") else {
                print("Error with getting url")
                return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("Error with getting data")
            return
        }
        
        let decoder = JSONDecoder()
        do{
            list = try decoder.decode([Password].self, from: data)
            count = list.count
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func encode() {
        guard let url = Bundle.main.url(forResource: "passwordlist", withExtension: "json") else {
                print("Error with getting url")
                return
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
                let file: FileHandle? = try FileHandle(forUpdating: url)
                let jsonData = try encoder.encode(list)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                let data = (jsonString as
                NSString).data(using: String.Encoding.utf8.rawValue)
                file?.truncateFile(atOffset: 0)
                file?.write(data!)
                file?.closeFile()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}


