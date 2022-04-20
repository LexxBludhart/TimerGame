//
//  ViewController.swift
//  TimerGame
//
//  Created by Rhett Levitz on 4/5/22.
//

import UIKit

import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var minValueInput: UITextField!
    
    @IBOutlet weak var maxValueInput: UITextField!
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var pauseButtonView: UIButton!
    
    @IBOutlet weak var startButtonView: UIButton!
    
    @IBOutlet weak var submitButtonView: UIButton!
    
    @IBOutlet weak var errorImage: UIImageView!
    
    @IBOutlet weak var errorNumberMessage: UILabel!
    
    @IBOutlet weak var errorLetterMessage: UILabel!
    
    @IBOutlet weak var poopImage: UIImageView!
    
    var audioPlayer: AVAudioPlayer!
    
    lazy var seconds = (Int.random(in: minValueAsInteger...maxValueAsInteger) + 1)
    var timer = Timer()
    var isTimerRunning = false
    var isPauseTapped = false
    var minValueAsInteger = 0
    var maxValueAsInteger = 0
    
    override func viewDidLoad() {
         super.viewDidLoad()
         pauseButtonView.isEnabled = false
        startButtonView.isEnabled = false
        errorImage.isHidden = true
        errorNumberMessage.isHidden = true
        errorLetterMessage.isHidden = true
        poopImage.isHidden = true
        countdownLabel.text = "-"
    }
    
    func playAudio(name soundFile: String , ofType fileType: String) {
        let url = Bundle.main.url(forResource: soundFile, withExtension: fileType)
               audioPlayer = try! AVAudioPlayer(contentsOf: url!)
               audioPlayer.play()
    }
    
    func checkMinMaxForInt() {
        let minValueInt = Int(minValueInput.text!) ?? nil
        let maxValueInt = Int(maxValueInput.text!) ?? nil
        if minValueInt == nil || maxValueInt == nil {
            minValueInput.backgroundColor = UIColor.red
            maxValueInput.backgroundColor = UIColor.red
            errorLetterMessage.isHidden = false
            poopImage.isHidden = false
            playAudio(name: "fart", ofType: "mp3")
        } else if minValueInt! >= maxValueInt!  {
            minValueInput.backgroundColor = UIColor.red
            maxValueInput.backgroundColor = UIColor.red
            errorImage.isHidden = false
            errorNumberMessage.isHidden = false
            playAudio(name: "tindeck_1", ofType: "mp3")
        } else if minValueInt == 6 && maxValueInt == 9 {
            minValueInput.backgroundColor = UIColor.green
            maxValueInput.backgroundColor = UIColor.green
            minValueAsInteger = minValueInt ?? 0
            maxValueAsInteger = maxValueInt ?? 0
            playAudio(name: "mmm-2", ofType: "wav")
        } else {
            minValueInput.backgroundColor = UIColor.green
            maxValueInput.backgroundColor = UIColor.green
            minValueAsInteger = minValueInt ?? 0
            maxValueAsInteger = maxValueInt ?? 0
            errorImage.isHidden = true
            errorLetterMessage.isHidden = true
            errorNumberMessage.isHidden = true
            poopImage.isHidden = true
        }
    }
    
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseButtonView.isEnabled = true
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        checkMinMaxForInt()
        if maxValueInput.backgroundColor == UIColor.red || minValueInput.backgroundColor == UIColor.red {
            self.startButtonView.isEnabled = false
        } else {
            self.startButtonView.isEnabled = true
        }
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        seconds = (Int.random(in: minValueAsInteger...maxValueAsInteger) + 1)
        if isTimerRunning == false {
            runTimer()
            self.startButtonView.isEnabled = false
        }
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        if self.isPauseTapped == false {
                  timer.invalidate()
                  self.isPauseTapped = true
             } else {
                  runTimer()
                  self.isPauseTapped = false
             }
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        timer.invalidate()
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        timer.invalidate()
        seconds = 0
        minValueAsInteger = 0
        maxValueAsInteger = 0
        minValueInput.text = ""
        maxValueInput.text = ""
        countdownLabel.text = "-"
        minValueInput.backgroundColor = UIColor.lightGray
        maxValueInput.backgroundColor = UIColor.lightGray
        isTimerRunning = false
        pauseButtonView.isEnabled = false
        self.startButtonView.isEnabled = false
        self.errorImage.isHidden = true
        self.errorNumberMessage.isHidden = true
        self.errorLetterMessage.isHidden = true
        self.poopImage.isHidden = true
        playAudio(name: "swoosh", ofType: "mp3")
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            self.pauseButtonView.isEnabled = false
            playAudio(name: "Wilhelm", ofType: "mp3")
            timer.invalidate()
        } else {
            playAudio(name: "timer_beep", ofType: "mp3")
        seconds -= 1
        countdownLabel.text = String(Int(TimeInterval(seconds)))
        }
    }
    
}

