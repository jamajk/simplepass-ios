//
//  AddingPasswordController.swift
//  SimplePass
//
//  Created by Jakub Majkowski on 08/01/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import UIKit
/*
enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}
*/
class AddingPasswordController: UIViewController {
    
    var list: PasswordList?

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    @IBAction func addClick(_ sender: Any) {
        let alert = UIAlertController(title: "Empty field", message: "Some field is empty and it cannot be [placeholder message]", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil ))
        
        if nameField.text?.isEmpty == true || userField.text?.isEmpty == true {
            self.present(alert, animated: true)
        }
        else {
            /*
            let account = userField.text!
            let password = passField.text!
            let server = nameField.text!
            let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                        kSecAttrAccount as String: account,
                                        kSecAttrServer as String: server,
                                        kSecValueData as String: password]
             let status = SecItemAdd(query as CFDictionary, nil)
  //          guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
 */ //keychain, not what i want to do here tbh
            
            
            //adding to the local array
            list?.addPassword(name: nameField.text!, user: userField.text!, password: passField.text!)
            
            self.delegate?.backFromSave()
            navigationController?.popViewController(animated: true)
        }
    }
    
    var password: String = ""
    var delegate: callFunc?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passField.text = password
    }
    
}
