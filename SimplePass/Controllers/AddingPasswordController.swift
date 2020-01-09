//
//  AddingPasswordController.swift
//  SimplePass
//
//  Created by Jakub Majkowski on 08/01/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import UIKit

class AddingPasswordController: UIViewController {

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
            self.delegate?.backFromSave()
            navigationController?.popViewController(animated: true)
        }
    }
    
    var password: String = "a"
    var delegate: callFunc?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passField.text = password
    }
    
}
