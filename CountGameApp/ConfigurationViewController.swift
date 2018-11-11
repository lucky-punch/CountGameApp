//
//  ConfigurationViewController.swift
//  CountGameApp
//
//  Created by nowall on 2018/11/10.
//  Copyright © 2018 鈴木貴大. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    @IBOutlet weak var switchOutlet: UISwitch!
    @IBOutlet weak var textLabel: UILabel!
    var switchButton = false
    var optionSwitch = false
    @IBOutlet weak var optionOutlet: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userDefaults.object(forKey: "option") != nil {
            switchButton = userDefaults.object(forKey: "button") as! Bool
            switchOutlet.isOn = switchButton
        }
        if userDefaults.object(forKey: "option") != nil {
            optionSwitch = userDefaults.object(forKey: "option") as! Bool
            optionOutlet.isOn = optionSwitch
        }
    }
    
    
    
    
    @IBAction func switchButton(_ sender: UISwitch) {
        if sender.isOn {
            switchButton = true
            userDefaults.set(switchButton, forKey:"button")
        } else {
            switchButton = false
            userDefaults.set(switchButton, forKey:"button")
        }
    }
    
    
    @IBAction func optionSwitch(_ sender: UISwitch) {
        if sender.isOn {
            optionSwitch = true
            userDefaults.set(optionSwitch, forKey:"option")
        } else {
            optionSwitch = false
            userDefaults.set(optionSwitch, forKey:"option")
        }
    }
    
    
    
    
}

