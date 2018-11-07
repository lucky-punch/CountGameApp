//
//  ViewController.swift
//  CountGameApp
//
//  Created by nowall on 2018/11/06.
//  Copyright © 2018 鈴木貴大. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var countTapLabel: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var optionsConstrait: NSLayoutConstraint!
    @IBOutlet weak var optionsLabel: UILabel!
    var number = 30
    let stringAttributes : [NSAttributedString.Key: Any] = [
    .font : UIFont.systemFont(ofSize: 37.0)
    ]
    //アニメーション関数
    func animation(withOne:Double, withTwo:Double, delayOne:Double, delayTwo:Double) {
        UIView.animate(withDuration:withOne, delay:delayOne, options: .curveEaseOut, animations: {
            //ここでタップボタンを隠す
            self.countTapLabel.isHidden = true
            self.optionsConstrait.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
            //終わったらアニメーションする
        }, completion: {(finished: Bool) in
            UIView.animate(withDuration: withTwo, delay:delayTwo, options: .curveEaseOut, animations: {
                self.optionsConstrait.constant += self.view.bounds.width
                self.view.layoutIfNeeded()
            }, completion: nil)
        })
        //アニメーションとタップラベルが消えている時間確保
        //Thred.sleepに問題がありそう(現状はisHiddenより先にThred.sleepが発動しているような動きになっている)
        //やりたいことはアニメーションが起こっている間はボタンを隠しアニメーションが終わったときにnボタンが現れるような動作の実現
        Thread.sleep(forTimeInterval: 3.0)
        //現れる
        self.countTapLabel.isHidden = false
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.text = String(number)
        //optionsLabelを画面から出す
        optionsConstrait.constant += view.bounds.width
    }
    
    
    
    //ボタンをタップしたとき
    @IBAction func countTapButton(_ sender: Any) {
        //1~100までランダムに値を入れてその値の範囲で確率を変える
        let probability = Int.random (in: 1 ... 100)
        print(probability)
        
        if probability <= 90 {
            number -= 1
            countLabel.text = String(number)
        } else if  probability > 90 && probability <= 95 {
            //self.countTapLabel.isHidden = true
            countTapLabel.isEnabled = false
            let string = NSAttributedString(string: "SKIP", attributes:stringAttributes)
            optionsLabel.attributedText = string
            animation(withOne:0.5, withTwo:0.5, delayOne:1.0, delayTwo:1.0)
            
        } else {
            //self.countTapLabel.isHidden = true
            countTapLabel.isEnabled = false
            let string = NSAttributedString(string: "REVERSE", attributes:stringAttributes)
            optionsLabel.attributedText = string
            animation(withOne:0.5, withTwo:0.5, delayOne:1.0, delayTwo:1.0)
        }
        
        if number == 0 {
            let string = NSAttributedString(string: "GAME OVER", attributes:stringAttributes)
            countLabel.attributedText = string
        }
        
    }
    
    
    


}
