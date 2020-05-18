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

protocol EditUpdate {
    func passOnEditTask()
    func updateDetails(newDetails: Password)
}

class DetailsViewController: UIViewController {
    
    var gotDetails: Password?
    var delegate: backComm?
    var number: Int?
    var blurEffectView: UIVisualEffectView!

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
        view.backgroundColor = .darkModeBlue
        let blurEffect = UIBlurEffect(style: .regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0
        view.addSubview(blurEffectView)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appInactiveAction), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appActiveAction), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    @objc func appInactiveAction() {
        showBlur()
    }
    
    @objc func appActiveAction() {
        hideBlur()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = gotDetails?.name ?? "error"
        userLabel.text = gotDetails?.username ?? "error"
        passLabel.text = gotDetails?.password ?? "error"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let controller = segue.destination as? EditingPasswordController else { fatalError("Invalid segue destination")
        }
        controller.password = gotDetails?.password ?? "Couldn't load"
        controller.username = gotDetails?.username ?? "Couldn't load"
        controller.name = gotDetails?.name ?? "Couldn't load"
        controller.index = number
        controller.delegate = self
    }
    
    private func showBlur() {
        print("blur show")
        view.bringSubviewToFront(blurEffectView)
        UIView.animate(withDuration: 0.3, animations: {
            self.blurEffectView.alpha = 1
        })
    }
    
    private func hideBlur() {
        print("blur hide")
        UIView.animate(withDuration: 0.3, animations: {
            self.blurEffectView.alpha = 0
        },completion: {_ in
            self.view.sendSubviewToBack(self.blurEffectView)
        })
    }
}

extension DetailsViewController: EditUpdate {
    func passOnEditTask() {
        guard let newPassword = gotDetails else { return }
        guard number != nil else { return }
        self.delegate?.Edit(index: number!, password: newPassword)
    }
    
    func updateDetails(newDetails: Password) {
        gotDetails = newDetails
    }
}
