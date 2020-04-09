//
//  EditingPasswordController.swift
//  SimplePass
//
//  Created by Jakub Majkowski on 01/04/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//
import UIKit

class EditingPasswordController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var passLabel: UILabel!
    
    var password: String = ""
    var username: String = ""
    var name: String = ""
    var list: PasswordList?
    var index: Int?
    var delegate: EditUpdate?
    
    
    @IBAction func saveClick(_ sender: Any) {
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
            guard let newName = nameField.text else { return }
            guard let newUser = userField.text else { return }
            guard let newPass = passField.text else { return }
            self.delegate?.updateDetails(newDetails: Password(name: newName, user: newUser, password: newPass))
            self.delegate?.passOnEditTask()
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.text = name
        userField.text = username
        passField.text = password
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
