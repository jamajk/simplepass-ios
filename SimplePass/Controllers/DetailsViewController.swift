//
//  DetailsViewController.swift
//  SimplePass
//
//  Created by Jakub Majkowski on 28/12/2019.
//  Copyright © 2019 Jakub Majkowski. All rights reserved.
//

import UIKit

enum AppError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

class DetailsViewController: UIViewController {
    
    var gotDetails: Password?
    var delegate: backComm?
    var number: Int?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var passLabel: UILabel!
    
    
    @IBAction func delClick(_ sender: Any) {
        let confirmation = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        confirmation.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            do {
                guard self.number != nil else {throw AppError.unexpectedPasswordData}
                self.delegate?.Delete(index: self.number!)
                self.navigationController?.popViewController(animated: true)
            }
            catch {
                print("Number is nil")
            }
        }))
        confirmation.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(confirmation, animated: true)
    }
    
    @IBAction func copyClick(_ sender: Any) {
        UIPasteboard.general.string = passLabel.text
        let alert = UIAlertController(title: "", message: "Password has been copied", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default action"), style: .default, handler: nil ))
            self.present(alert, animated: true)
    }
    
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
