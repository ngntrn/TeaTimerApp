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
    
   
    
    @IBOutlet weak var progressRing: ProgressBarView!
    var timer: Timer!
    var progressCounter: Float = 0
    var progressIncrement: Float = 0
    
    
    var tea: Tea?
    var nameValueToPass: String!
    var timeValueToPass: String!
    var secsValueToPass: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teaNameLabel.text = nameValueToPass
        teaTimeLabel.text = timeValueToPass
    }
    
    @IBAction func startBrewing(_ sender: UIButton) {
        let duration: Float = Float(secsValueToPass)
        progressIncrement = 1.0/duration
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:  #selector(self.showBrewProgress), userInfo: nil, repeats: true)
    }
    
    @objc func showBrewProgress(){
        if(progressCounter > 1.0){timer.invalidate()}
        progressRing.progress = progressCounter
        progressCounter = progressCounter + progressIncrement
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}
