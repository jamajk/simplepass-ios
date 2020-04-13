//
//  DarkColor.swift
//  SimplePass
//
//  Created by Jakub Majkowski on 13/04/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import UIKit

extension UIColor {
    static let darkModeBlue: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return UIColor.init(red: 17/255, green: 20/255, blue: 28/255, alpha: 1)
                } else {
                    return UIColor.systemBackground
                }
            }
        } else {
            return UIColor.systemBackground
        }
    }()
}
