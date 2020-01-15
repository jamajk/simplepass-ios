//
//  DetailsViewController.swift
//  SimplePass
//
//  Created by Jakub Majkowski on 28/12/2019.
//  Copyright © 2019 Jakub Majkowski. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var gotDetails: Password?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var passLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = gotDetails?.name ?? "error"
        userLabel.text = gotDetails?.username ?? "error"
        passLabel.text = gotDetails?.password ?? "error"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
