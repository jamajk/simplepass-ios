//
//  DetailsViewController.swift
//  SimplePass
//
//  Created by Jakub Majkowski on 28/12/2019.
//  Copyright © 2019 Jakub Majkowski. All rights reserved.
//

import UIKit

enum KeychainError: Error {
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

    @IBAction func saveClick(_ sender: Any) {
        addToKeychain()
    }
    
    @IBAction func delClick(_ sender: Any) {
        //TODO Add the "Are you sure?" alert and confirmation
        let confirmation = UIAlertController(title: "Confirm removal", message: "Are you sure that you want to delete the current entry?", preferredStyle: .alert)
        confirmation.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            do {
                guard self.number != nil else {throw KeychainError.unexpectedPasswordData}
                self.delegate?.Delete(index: self.number!)
                self.navigationController?.popViewController(animated: true)
            }
            catch {
                print("Number is nil")
            }
        }))
        confirmation.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(confirmation, animated: true)
    }
    
    @IBAction func copyClick(_ sender: Any) {
        UIPasteboard.general.string = passLabel.text
        let alert = UIAlertController(title: "", message: "Password has been copied", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default action"), style: .default, handler: nil ))
            self.present(alert, animated: true)
    }
    
    func addToKeychain() {
        let account = userLabel.text!
        let password = passLabel.text!
        let server = nameLabel.text!
        
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                   kSecAttrAccount as String: account,
                                   kSecAttrServer as String: server,
                                   kSecValueData as String: password]
        do {
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else {throw KeychainError.unhandledError(status: status) }
            let alert = UIAlertController(title: "Password added", message: "Your password has been added to Keychain", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default action"), style: .default, handler: nil ))
            self.present(alert, animated: true)
        }
        catch is KeychainError {
            print("Error with Keychain")
        }
        catch {
            print("Unknown error")
        }
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
