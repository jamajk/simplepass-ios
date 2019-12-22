//
//  Generator.swift
//  SimplePass
//
//  Created by Jakub Majkowski on 04/12/2019.
//  Copyright © 2019 Jakub Majkowski. All rights reserved.
//

import Foundation

class Generator {
    var length: Int = 14
    
    func generate() -> String {
        var pass: String = ""
        for _ in 1...length {
            pass += String(UnicodeScalar(Int.random(in: 33...126))!)
        }
        return pass
    }
}
