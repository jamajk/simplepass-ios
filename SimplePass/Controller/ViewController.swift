//
//  ViewController.swift
//  SimplePass
//
//  Created by Jakub Majkowski on 04/12/2019.
//  Copyright © 2019 Jakub Majkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let gen = Generator()
    
    @IBOutlet weak var passLabel: UILabel!
    @IBOutlet weak var lenLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var genButton: UIButton!
    
    @IBAction func genClick(_ sender: UIButton) {
        passLabel.text = gen.generate()
        passLabel.isHidden = false
        copyButton.isHidden = false
        infoLabel.isHidden = true
        saveButton.isHidden = false
    }
    @IBAction func valChange(_ sender: UISlider) {
        gen.length = Int(sender.value)
        passLabel.isHidden = true
        lenLabel.text = String(gen.length)
        copyButton.isHidden = true
        saveButton.isHidden = true
    }
    @IBAction func copyClick(_ sender: Any) {
        UIPasteboard.general.string = passLabel.text
        infoLabel.text = "The password has been copied to your pasteboard."
        infoLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.infoLabel.isHidden = true
        }
    }
    @IBAction func saveClick(_ sender: Any) {
        // TODO zapisywanie haseł gdzieś
        infoLabel.text = "The password has been saved."
        infoLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.infoLabel.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lenLabel.text = String(gen.length)
        passLabel.isHidden = true
        copyButton.isHidden = true
        saveButton.isHidden = true
        infoLabel.isHidden = true
        infoLabel.text = "  "
        colorView.layer.cornerRadius = 10
        genButton.layer.cornerRadius = 5
    }
}

