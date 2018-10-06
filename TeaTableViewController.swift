//
//  TeaTableViewController.swift
//  TeaTimer
//
//  Created by Lucky Tran  on 10/5/18.
//  Copyright © 2018 Ngan Tran. All rights reserved.
//

import UIKit

class TeaTableViewController: UITableViewController {
    
    //MARK: Properties
    var teas = [Tea]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleTeas()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
            vc.valueToPass = cell.nameLabel?.text
        }
    }
    
    
    // MARK: Actions
    @IBAction func unwindToTeaList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? EditTeaViewController, let tea = sourceViewController.tea{
            // add new tea
            let newIndexPath = IndexPath(row: teas.count, section: 0)
            teas.append(tea)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    // MARK: Private Methods
    private func loadSampleTeas(){
        guard let tea1 = Tea(name: "Green Tea", brewtime: 180) else{fatalError("Unable to instantiate tea 1")}
        
        guard let tea2 = Tea(name: "Black Tea", brewtime: 240) else{fatalError("Unable to instantiate tea 2")}
        
        guard let tea3 = Tea(name: "White Tea", brewtime: 150) else{fatalError("Unable to instantiate tea 3")}
        
        teas += [tea1, tea2, tea3]
    }

}
