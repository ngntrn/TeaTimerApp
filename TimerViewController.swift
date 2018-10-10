//
//  TimerViewController.swift
//  TeaTimer
//
//  Created by Lucky Tran  on 10/5/18.
//  Copyright © 2018 Ngan Tran. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UINavigationControllerDelegate{

    @IBOutlet weak var teaNameLabel: UILabel!
    @IBOutlet weak var teaTimeLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var progressRing: ProgressBarView!
    
    var timer: Timer!
    var progressCounter: Float = 0
    var progressIncrement: Float = 0
    var tea: Tea?
    var nameValueToPass: String!
    var timeValueToPass: String!
    var secsValueToPass: Int = 0
    var isTimeRunning = false
    var resumeBtnPushed = false
    var seconds: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seconds = secsValueToPass
        //disable the pause button
        pause.isEnabled = false
        teaNameLabel.text = nameValueToPass
        teaTimeLabel.text = timeString(time: TimeInterval(secsValueToPass))
        resetBtn.isEnabled = false 
    }
    
    @IBAction func startBrewing(_ sender: UIButton) {
        if isTimeRunning == false{
            //start the timer
            runTimer()
            //disable the start button while timer is running
            self.startBtn.isEnabled = false
            resetBtn.isEnabled = true
        }
    }
    
    @IBAction func resetBtn(_ sender: UIButton) {
        timer.invalidate()
        seconds = secsValueToPass
        teaTimeLabel.text = timeString(time: TimeInterval(seconds))
        progressIncrement = 1.0/Float(secsValueToPass)
        progressRing.progress = 0
        progressCounter = 0
        progressIncrement = 0
        isTimeRunning = false
        //disable the pause button
        pause.isEnabled = false
        startBtn.isEnabled = true
        self.pause.setTitle("Pause", for: .normal)
        self.resumeBtnPushed = false
    }
    
    @IBAction func pauseBtn(_ sender: UIButton) {
        if self.resumeBtnPushed == false{
            timer.invalidate()
            self.resumeBtnPushed = true
            self.pause.setTitle("Resume", for: .normal)
        }
        else{
            runTimer()
            self.resumeBtnPushed = false
            self.pause.setTitle("Pause", for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func runTimer(){
        progressRing.progress = 0
        let duration: Float = Float(secsValueToPass)
        progressIncrement = 1.0/duration
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        isTimeRunning = true
        //enable the pause button when timer is running
        pause.isEnabled = true
    }
    
    @objc func updateTimer(){
        if seconds < 1 && progressCounter > 1.0{
            timer.invalidate()
            alertDone()
        }
        else {
            progressRing.progress = progressCounter
            progressCounter = progressCounter + progressIncrement
            if seconds != 0{
                seconds -= 1
            }
            teaTimeLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time: TimeInterval) -> String{
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "EditTea" {
            let data = segue.destination as? EditTeaViewController
            data?.nameToPass = teaNameLabel.text
            data?.secsToPass = secsValueToPass
            
            print("seconds to pass: \(secsValueToPass)")
        }
    }
    
    func alertDone(){
        let alertController = UIAlertController(title: " ", message: "your tea is ready", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
