//
//  ListViewController.swift
//  SimplePass
//
//  Created by Jakub Majkowski on 28/12/2019.
//  Copyright © 2019 Jakub Majkowski. All rights reserved.
//

import UIKit

protocol backComm {
    func Delete(index: Int)
}

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var passList: PasswordList?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        let alert = UIAlertController(title: "Empty password list", message: "There are no passwords to show", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default action"), style: .default, handler: {action in self.navigationController?.popViewController(animated: true)}))
        
        if passList!.count < 1 {
            self.present(alert, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "showPasswordDetails" {
            guard let passwordDetails = segue.destination as? DetailsViewController, let cell = sender as? PasswordCell else { fatalError("Invalid segue destination") }

           guard let indexPath = tableView.indexPath(for: cell) else { print("Unknown cell tapped"); return }
            passwordDetails.gotDetails = passList!.list[indexPath.row]
            passwordDetails.delegate = self
            passwordDetails.number = indexPath.row
        }
    }
    

}

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PASSCELL", for: indexPath) as? PasswordCell else { fatalError("Incorrect cell type") }
        
        cell.nameLabel.text = passList!.list[indexPath.row].name
    
    return cell
    }
}

extension ListViewController: backComm {
    func Delete(index: Int) {
        passList?.deletePassword(index: index)
    }
}
