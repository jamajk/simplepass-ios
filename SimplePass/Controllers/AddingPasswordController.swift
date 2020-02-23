//
//  AddingPasswordController.swift
//  SimplePass
//
//  Created by Jakub Majkowski on 08/01/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import UIKit

class AddingPasswordController: UIViewController, UITextFieldDelegate {
    
    var list: PasswordList?
    var password: String = ""
    var delegate: callFunc?

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    @IBAction func cancelClick(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addClick(_ sender: Any) {
        let alert = UIAlertController(title: "Empty field", message: "Please fill all of the required fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default action"), style: .default, handler: nil ))
        
        if nameField.text?.isEmpty == true || userField.text?.isEmpty == true {
            self.present(alert, animated: true)
        }
        else {
            list?.addPassword(name: nameField.text!, user: userField.text!, password: passField.text!)
            
            self.delegate?.backFromSave()
            presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passField.text = password
        self.nameField.delegate = self
        self.userField.delegate = self
        self.passField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
