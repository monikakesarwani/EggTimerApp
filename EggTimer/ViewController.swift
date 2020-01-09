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
    
    //declaring dectionary for hold string and Int value (type of eggs and time in second : sorft: 5min, medium: 7min, hard: 12min )
    let eggTimes : [String: Int] = ["Soft" : 300, "Medium": 420, "Hard": 720]
    
    var timer: Timer?
   
    //to get the percentage we need to calculte totalTime and how many secondPassed
    var totalTime = 0
    var secondPassed = 0
    
    var player: AVAudioPlayer!
    
    //connected IBoutlet to update the titlelabel
    @IBOutlet weak var titleLabel: UILabel!
    
    //connected IBoutlet to update the progressBar
    @IBOutlet weak var progressbar: UIProgressView!
    
    
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        //stop or invaild the stimer
        timer?.invalidate()
        //when app launch set back to zero
        progressbar.progress = 0.0
        secondPassed = 0
        
        
        let hardness = sender.currentTitle! // soft, medium, hard
        print(eggTimes[hardness]!)
        
        titleLabel.text = hardness
        
        /*Instead of always counting down from 60s, set the countdown timer use the correct number of seconds it takes to boil the egg of choice, depending on which egg button was pressed */
        totalTime = eggTimes[hardness]!
        
        
        //timer code
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    
    @objc func updateTimer() {
        
        if secondPassed < totalTime {
            
            secondPassed += 1
            //before diving convert into float otherwise it not gone divide as asspected
            let percentageProgress = Float (secondPassed) / Float (totalTime)
            print (percentageProgress)
            progressbar.progress = Float(percentageProgress)
            print (Float(percentageProgress))
            

        } else {
            timer?.invalidate()
            titleLabel.text = "Done!"
            playSound()
            
    }
    
}
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }

}
