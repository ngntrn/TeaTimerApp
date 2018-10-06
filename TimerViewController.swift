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
    
    var tea: Tea?
    var valueToPass: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teaNameLabel.text = valueToPass

        // Do any additional setup after loading the view.
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
            data?.toPass = teaNameLabel.text
        }
    }
}
