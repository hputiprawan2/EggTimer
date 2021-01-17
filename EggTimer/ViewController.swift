//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTime = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer = Timer()
    var secondRemaining = 60
    var totalTime = 0
    var secondPassed = 0
    var player: AVAudioPlayer?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.layer.cornerRadius = 10.0
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        label.text = hardness
        secondRemaining = eggTime[hardness]! * 60
        totalTime = eggTime[hardness]! * 60
        timer.invalidate()
        progressBar.progress = 0.0
        secondPassed = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        countdown()
        if secondPassed < totalTime {
            secondPassed += 1
            progressBar.progress = Float(secondPassed) / Float(totalTime)
        } else {
            playSound()
            label.text = "Egg is done!!"
            timer.invalidate()
        }
    }
    
    private func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
    
    private func countdown() {
        let minutes = String(secondRemaining / 60)
        let seconds = String(secondRemaining % 60)
        if secondRemaining >= 0 {
            secondRemaining -= 1
            self.countDownLabel.text = "Remaining Time: \(minutes):\(seconds) minutes"
            print ("\(minutes):\(seconds) minutes")
        }
    }
    
    @IBAction func pressedStopButton(_ sender: UIButton) {
        player?.stop()
        timer.invalidate()
    }
}
