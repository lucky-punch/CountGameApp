//
//  ViewController.swift
//  CountGameApp
//
//  Created by nowall on 2018/11/06.
//  Copyright © 2018 鈴木貴大. All rights reserved.
//

import UIKit
//import LTMorphingLabel

class ViewController: UIViewController {

    
    
    @IBOutlet weak var countTapLabel: UIButton!
    
    
    @IBOutlet weak var countLabel: UILabel!
    //@IBOutlet weak var countLabel: LTMorphingLabel!
    
    @IBOutlet weak var optionsConstrait: NSLayoutConstraint!
    @IBOutlet weak var optionsLabel: UILabel!
    
    //全体の数
    var number = 0
    //一人が押した回数
    var count = 0
    //設定(ボタン回数制限)
    var switchButton = false
    var optionSwitch = false
    let userDefaults = UserDefaults.standard
    
    
    let stringAttributesTop : [NSAttributedString.Key: Any] = [
    .font : UIFont.systemFont(ofSize: 100.0)
    ]
    let stringAttributesMiddle : [NSAttributedString.Key: Any] = [
        .font : UIFont.systemFont(ofSize: 50.0)]
    
    var timer: Timer! = Timer()
    //var doneNumber: Int = 0
    let gambleZeroOne = [0,1]
    var index = 0
    var rouletteCount = 0
    
    //アニメーション関数
    func animation(withSkip:Double, withRev:Double, delaySkip:Double, delayRev:Double) {
        UIView.animate(withDuration:withSkip, delay:delaySkip, options: .curveEaseOut, animations: {
            //ここでタップボタンを隠す
            self.countTapLabel.isHidden = true
            self.optionsConstrait.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
            //アニメーション続1
        }, completion: {(finished: Bool) in
            UIView.animate(withDuration: withRev, delay:delayRev, options: .curveEaseOut, animations: {
                self.optionsConstrait.constant += self.view.bounds.width
                self.view.layoutIfNeeded()
                //アニメーション続2
            }, completion: {(finishedSecondAnim: Bool) in
                self.countTapLabel.isHidden = false
            })
        })
    }
    
    
    
    
    
    //timer起動、繰り返し処理。(speed:Double)でルーレットの速さを調整
    func roulette(speed:Double) {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(speed),
                                     target: self,
                                     selector: #selector(gambleRoulette(timer:)),
                                     userInfo: nil,
                                     repeats: true)
        timer?.fire()
    }
    //rouletteの中で呼び出される。effectを呼び出しルーレットが始まる。
    @objc func gambleRoulette(timer: Timer) {
        effect()
    }
    //ルーレット回転調整
    func effect() {
        switch rouletteCount {
        case 0..<7:
            rotation()
        case 7:
            speedUp(speedNumber: 0.05)
        case 8..<50:
            rotation()
            
        default:
            //timerを止める
            timer.invalidate()
            number = Int.random(in:0 ... 1)
            print("ここ\(number)")
            countLabel.text = String(number)
            if number == 0 {
                countTapLabel.isEnabled =  false
                //overView.isHidden = false
            } else {
                gambleOption.isHidden = true
            }
        }
    }
    //ルーレット回転
    func rotation() {
        countLabel.text = String(gambleZeroOne[index])
        print(countLabel.text)
        print("aaa\(index)")
        index += 1
        rouletteCount += 1
        if index >= gambleZeroOne.count {
            index = 0
        }
    }
    //ルーレット回転スピードアップ
    func speedUp(speedNumber:Double){
        countLabel.text = String(gambleZeroOne[index])
        rouletteCount += 1
        timer.invalidate()
        roulette(speed: speedNumber)
        if index >= gambleZeroOne.count {
            index = 0
        }
    }
    
    
    
    
    
    
    
    
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var skipOption: UIButton!
    @IBOutlet weak var reverseOption: UIButton!
    @IBOutlet weak var plusFiveOption: UIButton!
    @IBOutlet weak var nextOption: UIButton!
    @IBOutlet weak var gambleOption: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //countLabel.morphingEffect = .scale
        //optionsLabelを画面から出す
        optionsConstrait.constant += view.bounds.width
        number = UserDefaults.standard.integer(forKey:"number") 
        countLabel.text = String(number)
        if userDefaults.object(forKey: "button") != nil {
            switchButton = userDefaults.object(forKey: "button") as! Bool
        }
        if userDefaults.object(forKey: "option") != nil {
            optionSwitch = userDefaults.object(forKey: "option") as! Bool
        }
        
        
    }
    
    
    
    
    //ボタンをタップしたとき
    @IBAction func countTapButton(_ sender: Any) {
        skipOption.isHidden = true
        reverseOption.isHidden = true
        plusFiveOption.isHidden = true
        //1~100までランダムに値を入れてその値の範囲で確率を変える
        let probability = Float.random (in: 1 ... 100)
        if probability <= 80 {
            number -= 1
            countLabel.text = String(number)
        }
        //設定でスイッチがoFFなら発動
        if optionSwitch == false {
            if probability > 80 && probability <= 86 {
                skipOption.isHidden = false
                /*let string = NSAttributedString(string: "SKIP", attributes:stringAttributesMiddle)
                 optionsLabel.attributedText = string
                 animation(withSkip:0.3, withRev:0.5, delaySkip:0.0, delayRev:1.0)*/
                /*DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                 self.countTapLabel.isHidden = false
                 }*/
            } else if probability > 86 && probability <= 92 {
                //countTapLabel.isHidden = true
                reverseOption.isHidden = false
                /*let string = NSAttributedString(string: "REVERSE", attributes:stringAttributesMiddle)
                 optionsLabel.attributedText = string
                 animation(withSkip:0.3, withRev:0.5, delaySkip:0.0, delayRev:1.0)*/
                /*DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                 self.countTapLabel.isHidden = false
                 }*/
            } else if probability > 92 && probability <= 98 {
                plusFiveOption.isHidden = false
                /*let string = NSAttributedString(string: "＋５", attributes:stringAttributesMiddle)
                 optionsLabel.attributedText = string
                 animation(withSkip:0.3, withRev:0.5, delaySkip:0.0, delayRev:1.0)
                 number += 5
                 countLabel.text = String(number)*/
            } else if probability > 98 && probability <= 100 {
                countTapLabel.isHidden = true
                nextOption.isHidden = true
                countLabel.isHidden = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.gambleOption.isHidden = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.gambleOption.isHidden = true
                    self.countTapLabel.isHidden = false
                    self.countLabel.isHidden = false
                }
            }
        }
        
        
        if number <= 0 {
            countTapLabel.isEnabled = false
            overView.isHidden = false
      }
        
        
        count += 1
        
        //ボタン回数三回制限
        if switchButton == false {
            //カウントボタンの色
            switch count {
            case 1: countTapLabel.backgroundColor = UIColor(red: 28/255, green: 193/255, blue: 223/255, alpha: 1.0)
            case 2:countTapLabel.backgroundColor = UIColor(red: 115/255, green: 250/255, blue: 121/255, alpha: 1.0)
            case 3:countTapLabel.backgroundColor = UIColor.darkGray
            //countTapLabel.backgroundColor = UIColor(red: 175/255, green: 106/255, blue: 255/255, alpha: 1.0)
            countTapLabel.isEnabled = false
            default: break
            }
        }
        
    }
    
    
    //SKIP押したとき
    @IBAction func skipButton(_ sender: Any) {
        let string = NSAttributedString(string: "SKIP", attributes:stringAttributesMiddle)
        optionsLabel.attributedText = string
        animation(withSkip:0.3, withRev:0.5, delaySkip:0.0, delayRev:1.0)
        skipOption.isHidden = true
        count = 0
    }
    //REVERSE押したとき
    @IBAction func reverseButton(_ sender: Any) {
        let string = NSAttributedString(string: "REVERSE", attributes:stringAttributesMiddle)
        optionsLabel.attributedText = string
        animation(withSkip:0.3, withRev:0.5, delaySkip:0.0, delayRev:1.0)
        reverseOption.isHidden = true
        count = 0
    }
    //＋5押したとき
    @IBAction func plusFiveButton(_ sender: Any) {
        let string = NSAttributedString(string: "＋５", attributes:stringAttributesMiddle)
        optionsLabel.attributedText = string
        animation(withSkip:0.3, withRev:0.5, delaySkip:0.0, delayRev:1.0)
        number += 5
        countLabel.text = String(number)
        plusFiveOption.isHidden = true
        count = 0
    }
    
    //nextButton
    @IBAction func nextButton(_ sender: Any) {
        count = 0
        countTapLabel.isEnabled = true
        countTapLabel.backgroundColor = UIColor(red: 239/255, green: 98/255, blue: 189/255, alpha: 1.0)
    }
    
    //GAMBLE押したとき
    @IBAction func gambleButton(_ sender: Any) {
        countLabel.isHidden = false
        //animation
        roulette(speed: 0.3)
        if number == 0 {
            countTapLabel.isEnabled = false
            overView.isHidden = false
        } else {
            countTapLabel.isHidden = false
            countLabel.isHidden = false
        }
        
    }
    
    
    
    
    
    
    //retryButton
    @IBAction func retryButton(_ sender: Any) {
        overView.isHidden = true
        countTapLabel.isEnabled = true
        skipOption.isHidden = true
        reverseOption.isHidden = true
        plusFiveOption.isHidden = true
        //nextOption.isHidden = false
        gambleOption.isHidden = true
        number = UserDefaults.standard.object(forKey: "number") as! Int
        countLabel.text = String(number)
        countTapLabel.backgroundColor = UIColor(red: 239/255, green: 98/255, blue: 189/255, alpha: 1.0)
        count = 0
        rouletteCount = 0
    }
    
    
    
   
    
    
    
    
    
    //機能
    //ルール説明
    //オプションを選択できる
    //buttonTapしたときのanimation
    //retryButton
    //countUpcountDown
    //count+2 count+4
    


}
