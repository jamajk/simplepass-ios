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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var passLabel: UILabel!
    
    @IBAction func cancelClick(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addClick(_ sender: Any) {
        let alert = UIAlertController(title: "Empty field", message: "Please fill all of the required fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default action"), style: .default, handler: nil ))
        
        func check(field: UITextField, label: UILabel) {
            if field.text?.isEmpty == true {
                label.textColor = .systemRed
            } else if label.textColor == .systemRed {
                label.textColor = .label
            }
        }
        
        if nameField.text?.isEmpty == true || userField.text?.isEmpty == true || passField.text?.isEmpty == true {
            
            check(field: nameField, label: nameLabel)
            check(field: userField, label: userLabel)
            check(field: passField, label: passLabel)
            
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
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if traitCollection.userInterfaceStyle == .dark {
        view.backgroundColor = UIColor.init(red: 17/255, green: 20/255, blue: 28/255, alpha: 1)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
