//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let eggTime = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer = Timer()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        var count_time = eggTime[hardness]!
        timer.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            let minutes = String(count_time / 60)
            let seconds = String(count_time % 60)
                if count_time > 0 {
                    self.label.text = "\(minutes): \(seconds) minutes"
                    print ("\(minutes): \(seconds) minutes")
                    count_time -= 1
                } else {
                    print("Egg is done!!")
                    self.label.text = "Egg is done!!"
                    Timer.invalidate()
                }
            }
    }
}
