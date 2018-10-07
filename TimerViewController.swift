//
//  TimerViewController.swift
//  TeaTimer
//
//  Created by Lucky Tran  on 10/5/18.
//  Copyright © 2018 Ngan Tran. All rights reserved.
//

import UIKit
import UICircularProgressRing

class TimerViewController: UIViewController, UINavigationControllerDelegate{

    @IBOutlet weak var teaNameLabel: UILabel!
    
    @IBOutlet weak var progressRing: UICircularProgressRing!
    
    var tea: Tea?
    var nameValueToPass: String!
    var timeValueToPass: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teaNameLabel.text = nameValueToPass
        
        let progressRing = UICircularProgressRing(frame: CGRect(x: 0, y: 0, width: 240, height: 240))
        // Change any of the properties you'd like
        progressRing.maxValue = 50
        
        progressRing.startProgress(to: 49, duration: 2.0) {
            print("Done animating!")
            // Do anything your heart desires...
        }
        

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
        }
    }
}
