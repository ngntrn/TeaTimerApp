//
//  TeaTableViewController.swift
//  TeaTimer
//
//  Copyright © 2018 Ngan Tran. All rights reserved.
//

import UIKit
import os.log

var teas = [Tea]()
<<<<<<< HEAD

class TeaTableViewController: UITableViewController, UISearchBarDelegate {

    var teaIndexInTable: Int = 0

    // clear navigation bar
    struct System {
        static func clearNavigationBar(forBar navBar: UINavigationBar) {
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
            navBar.isTranslucent = true
        }
    }
=======
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98

class TeaTableViewController: UITableViewController, UISearchBarDelegate {
    
    var teaIndexInTable: Int = 0
    
    struct System {
        static func clearNavigationBar(forBar navBar: UINavigationBar) {
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
            navBar.isTranslucent = true
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD

        tableView.separatorColor = UIColor(white: 0.95 , alpha: 0.1)

        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)

=======
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        //setTableViewBackgroundColors(sender: self, UIColor.lightGray, UIColor.white)
        
        if let navController = navigationController {
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
        }
        
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
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

    @objc func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }
<<<<<<< HEAD


    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }


=======
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
  
    
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
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
        cell.nameLabel.addCharacterSpacing()
        cell.timeLabel.text = printTime(seconds: tea.brewtime)
<<<<<<< HEAD


        //print("\(tea.name) brew time: \(tea.brewtime)")
=======
        cell.secsLabel.text = String(tea.brewtime)
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98

        
        print("\(tea.name) brew time: \(tea.brewtime)")
        
        return cell
    }
    

<<<<<<< HEAD

=======
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


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

<<<<<<< HEAD

=======
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let rowToMove = teas[fromIndexPath.row]
        teas.remove(at: fromIndexPath.row)
        teas.insert(rowToMove, at: to.row)
<<<<<<< HEAD

        saveTeas()
    }

=======
        
        saveTeas()
    }

    
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
<<<<<<< HEAD

        self.navigationController?.setNavigationBarHidden(false, animated: true)

        // moving to ViewTea contoller - pass the tea index
=======
    
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
        if segue.identifier == "ViewTea" {
            let vc = segue.destination as! TimerViewController
<<<<<<< HEAD
            vc.teaIndexToPass = Int(tableView.indexPathForSelectedRow!.row)
            print("tea index: \(vc.teaIndexToPass)")

=======
            //vc.nameValueToPass = cell.nameLabel?.text
            //vc.timeValueToPass = cell.timeLabel?.text
            //vc.secsValueToPass = Int((cell.secsLabel?.text)!)!
            vc.teaIndexToPass = Int(tableView.indexPathForSelectedRow!.row)
            print("tea index: \(vc.teaIndexToPass)")
            
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
        }
    }


    // MARK: Actions
    @IBAction func unwindToViewControllerWithSender(sender: UIStoryboardSegue){
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
<<<<<<< HEAD


    // MARK: Private Methods
    private func loadSampleTeas(){

        // add the sample teas to the tea table

        guard let tea1 = Tea(name: "Black Tea", brewtime: 240)
            else{fatalError("Unable to instantiate tea 1")}

        guard let tea2 = Tea(name: "Green Tea", brewtime: 180)
            else{fatalError("Unable to instantiate tea 2")}

        guard let tea3 = Tea(name: "Herbal Tea", brewtime: 300)
            else{fatalError("Unable to instantiate tea 3")}

        guard let tea4 = Tea(name: "Oolong Tea", brewtime: 240)
            else{fatalError("Unable to instantiate tea 4")}

        guard let tea5 = Tea(name: "White Tea", brewtime: 150)
            else{fatalError("Unable to instantiate tea 5")}

        teas += [tea1, tea2, tea3, tea4, tea5]
    }

=======
    
    
    // MARK: Private Methods
    private func loadSampleTeas(){
        guard let tea1 = Tea(name: "Green Tea", brewtime: 180)
            else{fatalError("Unable to instantiate tea 1")}
        
        guard let tea2 = Tea(name: "Black Tea", brewtime: 240)
            else{fatalError("Unable to instantiate tea 2")}
        
        guard let tea3 = Tea(name: "White Tea", brewtime: 150)
            else{fatalError("Unable to instantiate tea 3")}
        
        teas += [tea1, tea2, tea3]
    }
    
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
    private func saveTeas(){
        do{
            try NSKeyedArchiver.archivedData(withRootObject: teas, requiringSecureCoding: false).write(to: Tea.ArchiveURL)
        } catch{
            print("Error writing file")
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

<<<<<<< HEAD
    // converts time to hours:minutes:seconds
    func convertTime(seconds: Int) ->(Int, Int, Int){

        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    // prints time as minutes:seconds
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

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        self.navigationController?.setNavigationBarHidden(velocity.y > 0, animated: true)
=======
    func returnSecs(seconds: Int) ->Int{
        let (_,_,s) = convertTime(seconds: seconds)
        return s
    }

    func returnMins(seconds: Int) ->Int{
        let (_,m,_) = convertTime(seconds: seconds)
        return m
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
    }
}
