//
//  TeaTableViewController.swift
//  TeaTimer
//
//  Created by Lucky Tran  on 10/5/18.
//  Copyright © 2018 Ngan Tran. All rights reserved.
//

import UIKit
import os.log

class TeaTableViewController: UITableViewController {
    
    //MARK: Properties
    var teas = [Tea]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // use edit button
        navigationItem.leftBarButtonItem = editButtonItem
        
        // load saved teas
        if let savedTeas = loadTeas(){
            teas += savedTeas
        }
        // else load sample tea data
        else{
            loadSampleTeas()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TeaTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TeaTableViewCell else{
            fatalError("the dequeued cell is not an instance of TeaTableViewCell")
        }
        
        let tea = teas[indexPath.row]
        
        cell.nameLabel.text = tea.name
        cell.timeLabel.text = printTime(seconds: tea.brewtime)
        cell.secsLabel.text = String(tea.brewtime)

        
        print("\(tea.name) brew time: \(tea.brewtime)")
        
        return cell
    }
    
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            teas.remove(at: indexPath.row)
            saveTeas()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        if segue.identifier == "ViewTea" {
            let cell = sender as! TeaTableViewCell
            let vc = segue.destination as! TimerViewController
            vc.nameValueToPass = cell.nameLabel?.text
            vc.timeValueToPass = cell.timeLabel?.text
            vc.secsValueToPass = Int((cell.secsLabel?.text)!)!
            
            print("seconds: \(vc.secsValueToPass)")
        }
    }
    
    
    // MARK: Actions
    @IBAction func unwindToTeaList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? EditTeaViewController, let tea = sourceViewController.tea{
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                // update existing tea
                teas[selectedIndexPath.row] = tea
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                // add new tea
                let newIndexPath = IndexPath(row: teas.count, section: 0)
                teas.append(tea)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // save the teas in list
            saveTeas()
        }
    }
    
    // MARK: Private Methods
    private func loadSampleTeas(){
        guard let tea1 = Tea(name: "Green Tea", brewtime: 180) else{fatalError("Unable to instantiate tea 1")}
        
        guard let tea2 = Tea(name: "Black Tea", brewtime: 240) else{fatalError("Unable to instantiate tea 2")}
        
        guard let tea3 = Tea(name: "White Tea", brewtime: 150) else{fatalError("Unable to instantiate tea 3")}
        
        teas += [tea1, tea2, tea3]
    }
    
    private func saveTeas(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(teas, toFile: Tea.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Teas successfully saved", log: OSLog.default, type: .debug)
        }
        else{
            os_log("Failed to save", log: OSLog.default, type: .error)
        }
    }
    
    private func loadTeas() -> [Tea]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Tea.ArchiveURL.path) as? [Tea]
    }
    
    func convertTime(seconds: Int) ->(Int, Int, Int){
        
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func printTime(seconds: Int) ->String!{
        let (_,m,s) = convertTime(seconds: seconds)
        
        if s < 10 && s > 0{
            return ("\(m) : 0\(s) ")
        }
        else if s > 0{
            return ("\(m) : \(s) ")
        }
        else{
            return ("\(m) : \(s)0 ")
        }
        
    }

    func returnSecs(seconds: Int) ->Int{
        let (_,_,s) = convertTime(seconds: seconds)
        return s
    }

    func returnMins(seconds: Int) ->Int{
        let (_,m,_) = convertTime(seconds: seconds)
        return m
    }
}
