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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    var player: AVAudioPlayer!
    var timer = Timer()

    let eggTimes = ["Soft": 20, "Medium": 480, "Hard": 720]
    var countdown = 0
    var progress:Float = 0
    var secondsRemaining = 0

    @IBAction func hardnessSelected(_ sender: UIButton) {
        player?.stop()
        timer.invalidate()
        let hardness = sender.currentTitle!
        secondsRemaining = eggTimes[hardness]!
        countdown = secondsRemaining
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if countdown > 0 {
            countdown -= 1
            progress = Float(Float(secondsRemaining - countdown) / Float(secondsRemaining))
            print(progress)
            progressBar.progress = progress
        }
        else {
            titleLabel.text = "Done"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
}
