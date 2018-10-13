//
//  TimerViewController.swift
//  TeaTimer
//
//  Created by Lucky Tran  on 10/5/18.
//  Copyright © 2018 Ngan Tran. All rights reserved.
//

import UIKit
import AVFoundation
import Lottie
import UserNotifications

// undo till here

class TimerViewController: UIViewController, UINavigationControllerDelegate{
    
    struct System {
        static func clearNavigationBar(forBar navBar: UINavigationBar) {
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
            navBar.isTranslucent = true
        }
    }
    
    @IBOutlet weak var teaNameLabel: UILabel!
    @IBOutlet weak var teaTimeLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    var player: AVAudioPlayer?
    var timer: Timer!
    var tea: Tea?
    var nameValueToPass: String!
    var timeValueToPass: String!
    var secsValueToPass: Int = 0
    var isTimeRunning = false
    var stopBtnPushed = false
    var seconds: Int = 0

    var timeInterval = 0
    var startDate = Date()
    
    let systemSoundID: SystemSoundID = 1322
    let animationView = LOTAnimationView(name: "wave")
    
    var endingTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        NotificationCenter.default.addObserver(self, selector: #selector(observerMethod), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(observerMethod), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        if let navController = navigationController {
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
        }
        
        seconds = secsValueToPass
        teaNameLabel.text = nameValueToPass
        teaTimeLabel.text = timeString(time: TimeInterval(secsValueToPass))
        
        resetBtn.isEnabled = false
    }
    
    
    @IBAction func startBrewing(_ sender: UIButton) {
        animationView.isHidden = false
        if self.stopBtnPushed == false{
            self.startBtn.setTitle("STOP", for: .normal)
            
            if isTimeRunning == false{
                startDate = Date()
                //start the timer
                runTimer()
                resetBtn.isEnabled = true
            }
            else{
                startDate = Date().addingTimeInterval(TimeInterval(timeInterval))
            }
            
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "It's Tea Time"
            notificationContent.subtitle = ""
            notificationContent.body = "Your tea is ready! Enjoy."

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
            
            let request = UNNotificationRequest(identifier: "TeaDone",
                                                content: notificationContent,
                                                trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            self.stopBtnPushed = true
        }
        else{
            animationView.isHidden = true
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            timer.invalidate()
            self.stopBtnPushed = false
            self.startBtn.setTitle("START", for: .normal)
            self.startBtn.isEnabled = false
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    @IBAction func resetBtn(_ sender: UIButton) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        timer.invalidate()
        
        seconds = secsValueToPass
        teaTimeLabel.text = timeString(time: TimeInterval(seconds))
        
        animationView.isHidden = true
        
        isTimeRunning = false
        stopBtnPushed = false 
        startBtn.setTitle("START", for: .normal)
        startBtn.isEnabled = true
    }
    
    @objc func observerMethod(notification: NSNotification){
        if notification.name == UIApplication.didEnterBackgroundNotification {
            print("app entering background")
    
            
            // stop UI update
            timer.invalidate()
        } else if notification.name == UIApplication.didBecomeActiveNotification {
            print("app entering foreground")
                seconds = secsValueToPass - Int(floor(-startDate.timeIntervalSinceNow))
                runTimer()
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func runTimer(){
        //hide the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        isTimeRunning = true
        runAnimation()
    }
    
    @objc func updateTimer(){
        if seconds < 1 {
            timer.invalidate()
            alertDone()
            isTimeRunning = false
        }
        else {
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
    
    @IBAction func unwindToTeaListWithSender(segue: UIStoryboardSegue) {
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        animationView.isHidden = true
        
        if segue.identifier == "EditTea" {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            let data = segue.destination as? EditTeaViewController
            data?.nameToPass = teaNameLabel.text
            data?.secsToPass = secsValueToPass
            
            print("seconds to pass: \(secsValueToPass)")
        }
        
    }
    
    func alertDone(){
        
        /*
        let alertController = UIAlertController(title: " ", message: "your tea is ready", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        AudioServicesPlaySystemSound(systemSoundID)
        present(alertController, animated: true, completion: nil)
        */
        teaTimeLabel.text = "DONE!"
        playSound()
        // turn the waves animation off
        animationView.stop()
        animationView.isHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func
        runAnimation(){
        
        animationView.frame = CGRect(x:0, y:0, width: 1000, height: 1000)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        animationView.animationSpeed = 0.2
        view.addSubview(animationView)
        view.sendSubviewToBack(animationView)
        
        if isTimeRunning == true{
            animationView.play()
        }
    }
    
    func playSound(){
        guard let url = Bundle.main.url(forResource: "teachime", withExtension: "mp3") else{return}
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            player!.play()
            
        }catch let error as NSError{
            print("error: \(error.localizedDescription)")
        }
    }
}


