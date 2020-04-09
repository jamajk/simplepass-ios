//
//  PasswordCell.swift
//  SimplePass
//
//  Created by Jakub Majkowski on 28/12/2019.
//  Copyright © 2019 Jakub Majkowski. All rights reserved.
//

import UIKit

class PasswordCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if traitCollection.userInterfaceStyle == .dark {
            backgroundColor = UIColor.init(red: 17/255, green: 20/255, blue: 28/255, alpha: 1)
        }
    }
}
