//
//  HomeViewController.swift
//  CountGameApp
//
//  Created by nowall on 2018/11/08.
//  Copyright © 2018 鈴木貴大. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var topCountLabel: UILabel!
    @IBOutlet weak var startColor: UIButton!
    @IBOutlet weak var numberSlider: UISlider!
    
    
    let userDefaults = UserDefaults.standard
    let thirtyNumber = 30
    let fiftyNumber = 50
    let oneHundredNumber = 100
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startColor.backgroundColor = UIColor(red: 115/255, green: 252/255, blue: 214/255, alpha: 1)
        //sliderの最小値と最大値を設定
        numberSlider.minimumValue = 0
        numberSlider.maximumValue = 100
        //sliderの初期位置を設定
        numberSlider.value = 50
    }
    
    
    
    @IBAction func startButton(_ sender: Any) {
        userDefaults.set(thirtyNumber, forKey: "number")
    }
    
    //30,50,100のボタン押したとき
    @IBAction func thirtyButton(_ sender: Any) {
        userDefaults.set(thirtyNumber, forKey:"number")
        topCountLabel.text = String(thirtyNumber)
        startColor.backgroundColor = UIColor(red: 236/255, green: 33/255, blue: 78/255, alpha: 1)
    }
    @IBAction func fiftyButton(_ sender: Any) {
        userDefaults.set(fiftyNumber, forKey:"number")
        topCountLabel.text = String(fiftyNumber)
        startColor.backgroundColor = UIColor(red: 255/255, green: 239/255, blue: 71/255, alpha: 1)
    }
   @IBAction func oneHundredButton(_ sender: Any) {
        userDefaults.set(oneHundredNumber, forKey:"number")
        topCountLabel.text = String(oneHundredNumber)
        startColor.backgroundColor = UIColor(red: 49/255, green: 65/255, blue: 170/255, alpha: 1)
    }
    
    
    
    //カウントスライダー
    @IBAction func countSlider(_ sender: Any) {
        if numberSlider.value <= 33 {
            startColor.backgroundColor = UIColor(red: 236/255, green: 33/255, blue: 78/255, alpha: 1)
        } else if numberSlider.value > 33 && numberSlider.value <= 67 {
            startColor.backgroundColor = UIColor(red: 255/255, green: 239/255, blue: 71/255, alpha: 1)
        } else {
            startColor.backgroundColor = UIColor(red: 49/255, green: 65/255, blue: 170/255, alpha: 1)
        }
        topCountLabel.text = String(Int(numberSlider.value))
        userDefaults.set(numberSlider.value, forKey:"number")
    }
        
    
    //画面遷移で戻ってきたとき
    @IBAction func unwindAction (segue: UIStoryboardSegue) {
        startColor.backgroundColor = UIColor(red: 155/255, green: 252/255, blue: 214/255, alpha: 1)
        topCountLabel.text = ("COUNT")
    }
    
    
    
}


//optionの設定
