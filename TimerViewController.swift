//
//  TimerViewController.swift
//  TeaTimer
//
//  Copyright © 2018 Ngan Tran. All rights reserved.
//

import UIKit
import AVFoundation
import Lottie
import UserNotifications
import AudioToolbox

class TimerViewController: UIViewController, UINavigationControllerDelegate {
<<<<<<< HEAD

=======
    
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
    struct System {
        static func clearNavigationBar(forBar navBar: UINavigationBar) {
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
            navBar.isTranslucent = true
        }
    }
<<<<<<< HEAD

=======
    
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
    @IBOutlet weak var teaNameLabel: UILabel!
    @IBOutlet weak var teaTimeLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
<<<<<<< HEAD
    @IBOutlet weak var teaCupImage: UIImageView!

=======
    @IBOutlet weak var doneImageSpring: SpringImageView!
    
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
    var player: AVAudioPlayer?
    var timer: Timer!
    var tea: Tea!
    var startDate = Date()
<<<<<<< HEAD

=======
    
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
    var teaIndexToPass: Int = 0
    var isTimeRunning = false
    var stopBtnPushed = false
    var doneBtnPushed = false
    var seconds: Int = 0
    var timeInterval = 0
    var teaName = String()
<<<<<<< HEAD
    var alreadyAlerted = false

    // tea done alert sound id
    let systemSoundID: SystemSoundID = 1322

    // tea brewing animation Lottie file
    let animationView = LOTAnimationView(name: "teawaves")

    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {

        super.viewDidLoad()

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(observerMethod), name: UIApplication.didEnterBackgroundNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(observerMethod), name: UIApplication.didBecomeActiveNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(observerMethod), name: UIApplication.willResignActiveNotification, object: nil)

=======
    
    let systemSoundID: SystemSoundID = 1322
    let animationView = LOTAnimationView(name: "wave")
    let doneImage = UIImage(named:"doneImg.png")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(observerMethod), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(observerMethod), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
        if let navController = navigationController {
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
        }
<<<<<<< HEAD

        teaCupImage.isHidden = true

        tea = teas[teaIndexToPass]
        teaName = tea.name
        seconds = tea.brewtime

        teaNameLabel.text = teaName.capitalized
        teaNameLabel.addCharacterSpacing()
        teaTimeLabel.text = timeString(time: TimeInterval(tea.brewtime))

        startBtn.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.5)
        startBtn.layer.cornerRadius = 5

        resetBtn.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.5)
        resetBtn.layer.cornerRadius = 5

        doneBtn.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.5)
        doneBtn.layer.cornerRadius = 5

        resetBtn.isEnabled = false
        doneBtn.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
    }

    // starts the tea brewing
    @IBAction func startBrewing(_ sender: UIButton) {
        alreadyAlerted = false
        animationView.isHidden = false

        // if the stop button has not been pushed
        if self.stopBtnPushed == false{

            UIApplication.shared.isIdleTimerDisabled = true

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

            // set up notification for when app is not open and tea is ready
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "It's Tea Time"
            notificationContent.body = "Your tea is ready! Enjoy."
            notificationContent.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "teachime.mp3"))

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)

            let request = UNNotificationRequest(identifier: "TeaDone",
                                                content: notificationContent,
                                                trigger: trigger)

            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            self.stopBtnPushed = true
        }

        // else if stop button has been pushed
        else{
            // remove any pending notifications
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

            animationView.isHidden = true
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            timer.invalidate()
            self.stopBtnPushed = false
            self.startBtn.setTitle("START", for: .normal)
            self.startBtn.isEnabled = false
            startBtn.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.1)
        }
    }

    // reset button pushed
    @IBAction func resetBtn(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        teaNameLabel.isHidden = false
        timer.invalidate()
        teaTimeLabel.text = timeString(time: TimeInterval(tea.brewtime))
        animationView.isHidden = true
        isTimeRunning = false
        stopBtnPushed = false
        startBtn.setTitle("START", for: .normal)
        startBtn.isEnabled = true
        startBtn.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.5)
    }

    // done button pushed
    @IBAction func doneBtnAction(_ sender: UIButton) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        teaCupImage.stopAnimating()
        teaCupImage.isHidden = true
        alreadyAlerted = true
        self.doneBtn.setTitle("DONE", for: .normal)
        player?.stop()
        doneBtn.isHidden = true
        startBtn.isHidden = false
        resetBtn.isHidden = false
        startBtn.setTitle("START", for: .normal)
        startBtn.isEnabled = false
        teaTimeLabel.isHidden = false
        teaNameLabel.isHidden = false
        startBtn.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.1)
    }

    // track the status of the application
    @objc func observerMethod(notification: NSNotification){
        if notification.name == UIApplication.didEnterBackgroundNotification {
            // stop UI update
            if isTimeRunning == true{
                timer.invalidate()
            }
        } else if notification.name == UIApplication.didBecomeActiveNotification {
                seconds = tea.brewtime - Int(floor(-startDate.timeIntervalSinceNow))
                runTimer()
        }
        else if notification.name == UIApplication.willResignActiveNotification{
            if isTimeRunning == true{
                timer.invalidate()
            }
        }
=======
        
        print("\(teaIndexToPass)")
        
        tea = teas[teaIndexToPass]
        
        teaName = tea.name
        seconds = tea.brewtime
        
        print("tea name: \(teaName)")
        print("brew time: \(seconds)")
        
        teaNameLabel.text = teaName.uppercased()
        teaNameLabel.addCharacterSpacing()
        teaTimeLabel.text = timeString(time: TimeInterval(tea.brewtime))
        
        startBtn.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.5)
        startBtn.layer.cornerRadius = 10
        
        resetBtn.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.5)
        resetBtn.layer.cornerRadius = 10
        
        doneBtn.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.5)
        doneBtn.layer.cornerRadius = 10
        
        resetBtn.isEnabled = false
        doneBtn.isHidden = true
        doneImageSpring.isHidden = true
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
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
            notificationContent.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "teachime.mp3"))

<<<<<<< HEAD

=======
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
            startBtn.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.1)
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    @IBAction func resetBtn(_ sender: UIButton) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        teaNameLabel.isHidden = false
        timer.invalidate()
        seconds = tea.brewtime
        teaTimeLabel.text = timeString(time: TimeInterval(seconds))
        animationView.isHidden = true
        doneImageSpring.isHidden = true
        isTimeRunning = false
        stopBtnPushed = false 
        startBtn.setTitle("START", for: .normal)
        startBtn.isEnabled = true
        startBtn.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.5)
    }
    
    @IBAction func doneBtnAction(_ sender: UIButton) {
        self.doneBtn.setTitle("DONE", for: .normal)
        player?.stop()
        doneBtn.isHidden = true
        startBtn.isHidden = false
        resetBtn.isHidden = false
        startBtn.setTitle("START", for: .normal)
        startBtn.isEnabled = false
        doneImageSpring.isHidden = true
        teaTimeLabel.isHidden = false
        teaNameLabel.isHidden = false
        startBtn.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.1)
    }
    
    @objc func observerMethod(notification: NSNotification){
        if notification.name == UIApplication.didEnterBackgroundNotification {
            print("app entering background")
            // stop UI update
            if isTimeRunning == true{
                timer.invalidate()
            }
        } else if notification.name == UIApplication.didBecomeActiveNotification {
            print("app entering foreground")
                seconds = tea.brewtime - Int(floor(-startDate.timeIntervalSinceNow))
                runTimer()
        }
    }
        
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

<<<<<<< HEAD
    // run the tea brewing timer
    func runTimer(){
        // hide the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)

=======
    func runTimer(){
        // hide the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        isTimeRunning = true
        runAnimation()
    }
<<<<<<< HEAD

    // animates the image when tea is done brewing / timer is up
    func animateImage(imageView: UIImageView, images: [UIImage]){
        //print("animating image")
        teaCupImage.isHidden = false
        imageView.animationImages = images
        imageView.animationDuration = 5.0
        imageView.animationRepeatCount = 50
        imageView.startAnimating()
    }

    // timer function - change the numbers
    @objc func updateTimer(){
        if seconds < 1 {
            timer.invalidate()
            if alreadyAlerted == false{
                alertDone()
                startBtn.isEnabled = false
                isTimeRunning = false
                doneBtn.isHidden = false
                startBtn.isHidden = true
                resetBtn.isHidden = true
                alreadyAlerted = true
                if doneBtnPushed == false{
                    animateImage(imageView: teaCupImage, images: teaCupImages)
                }
            }
=======
    
    @objc func updateTimer(){
        if seconds < 1 {
            alertDone()
            timer.invalidate()
            startBtn.isEnabled = false
            isTimeRunning = false
            doneBtn.isHidden = false
            startBtn.isHidden = true
            resetBtn.isHidden = true
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
        }
        else {
            if seconds != 0{
                seconds -= 1
            }
            teaTimeLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
<<<<<<< HEAD

    // prints the time in minutes:seconds
=======
    
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
    func timeString(time: TimeInterval) -> String{
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
<<<<<<< HEAD



    func alertDone(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        teaNameLabel.isHidden = true
        teaTimeLabel.isHidden = true
        // turn the waves animation off
        animationView.stop()
        animationView.isHidden = true
        playSound()
        // vibrate phone
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        startBtn.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.1)
    }

    func runAnimation(){

        animationView.frame = CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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

            player?.numberOfLoops = -1

        }catch let error as NSError{
            print("error: \(error.localizedDescription)")
        }
    }

=======
    
    @IBAction func unwindToTeaListWithSender(segue: UIStoryboardSegue) {
    }
    
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        animationView.isHidden = true
<<<<<<< HEAD

        if segue.identifier == "EditTea" {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            let data = segue.destination as? EditTeaViewController
            //data?.nameToPass = teaNameLabel.text
            data?.teaIndexValToPass = teaIndexToPass
        }
    }

    @IBAction func unwindToViewControllerWithSender(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? EditTeaViewController, let tea = sourceViewController.tea{

            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            viewDidLoad()
            teaNameLabel.text = tea.name

            seconds = tea.brewtime
            teaTimeLabel.text = timeString(time: TimeInterval(tea.brewtime))
            // update existing tea
            teas[teaIndexToPass] = tea

            // save the tea in list
            do{
                try NSKeyedArchiver.archivedData(withRootObject: teas, requiringSecureCoding: false).write(to: Tea.ArchiveURL)
                //print("tea was updated")
            } catch{
                //print("Error saving updated tea")
            }
=======
        
        if segue.identifier == "EditTea" {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            let data = segue.destination as? EditTeaViewController
            //data?.nameToPass = teaNameLabel.text
            data?.teaIndexValToPass = teaIndexToPass
            

        }
        
    }
    
    func alertDone(){
        doneImageSpring.isHidden = false
        teaNameLabel.isHidden = true
        doneImageSpring.animation = "swing"
        doneImageSpring.force = 0.2
        doneImageSpring.duration = 4
        doneImageSpring.repeatCount = 10
        doneImageSpring.animate()
        
        teaTimeLabel.isHidden = true
        // turn the waves animation off
        animationView.stop()
        animationView.isHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        playSound()
        // vibrate phone
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        startBtn.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.1)
    }
    
    func runAnimation(){
        
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
        
            player?.numberOfLoops = -1
            
        }catch let error as NSError{
            print("error: \(error.localizedDescription)")
        }
    }
    
    @IBAction func unwindToViewControllerWithSender(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? EditTeaViewController, let tea = sourceViewController.tea{
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            viewDidLoad()
            teaNameLabel.text = tea.name
            teaTimeLabel.text = timeString(time: TimeInterval(tea.brewtime))
            seconds = tea.brewtime
            
            // update existing tea
            teas[teaIndexToPass] = tea
            
            // save the tea in list
            do{
                try NSKeyedArchiver.archivedData(withRootObject: teas, requiringSecureCoding: false).write(to: Tea.ArchiveURL)
                print("tea was updated hi")
            } catch{
                print("Error saving updated tea")
            }
            
            
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
        }
    }
}
