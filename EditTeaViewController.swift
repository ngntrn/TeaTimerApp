//
//  EditTeaViewController.swift
//  TeaTimer
//
//  Copyright © 2018 Ngan Tran. All rights reserved.
//

import UIKit
import os.log


class EditTeaViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var brewTimeField: UITextField!
    @IBOutlet weak var timePicker: UIPickerView! 
    
    @IBOutlet weak var saveButton: UIButton!
    var tea: Tea?

    var teaIndexValToPass: Int! 
    
    let  timeData = [["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
                     ["0", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"]]
    
    let minComponent = 0
    let secComponent = 1
    
    var brewTimeInSecs: Int = 0
    
    struct System {
        static func clearNavigationBar(forBar navBar: UINavigationBar) {
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
            navBar.isTranslucent = true
        }
    }
    
    // MARK: Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
    
        let isInAddTeaMode = presentingViewController is UINavigationController
        
        if isInAddTeaMode {
           dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else{
            fatalError("EditTeaViewController is not inside a navigation controller")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isHidden = true
        
        // determine which mode we're in; editing or adding tea
        if teaIndexValToPass != nil{
            editingMode()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        if let navController = navigationController {
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
        }
        
        updateSaveButtonState()
        saveButton.layer.cornerRadius = 5
        nameTextField.addBottomBorder()
        brewTimeField.addBottomBorder()
        nameTextField.delegate = self
        timePicker.delegate = self
        timePicker.dataSource = self
        timePicker.isHidden = true
        brewTimeField.delegate = self
        
        // enable save button only if text field has input
        updateSaveButtonState()
    }

    // edit tea data
    func editingMode(){
        
        timePicker.delegate = self
        timePicker.dataSource = self
        
        tea = teas[teaIndexValToPass]
        nameTextField.text = tea?.name.capitalized
        
        let s = returnSecs(seconds: (tea?.brewtime)!)
        let m = returnMins(seconds: (tea?.brewtime)!)
        
        brewTimeField.text =  String(m) + "m " + String(s) + "s "
        //print("m\(m):s\(s)")
        
        //minutes
        timePicker.selectRow(m, inComponent: minComponent, animated: false)
        
        //seconds
        timePicker.selectRow((s/5), inComponent: secComponent, animated: false)
        timePicker.resignFirstResponder()
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        timePicker.isHidden = true
        
        saveButton.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func convertTime(seconds: Int) ->(Int, Int, Int){
        
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func returnMins(seconds: Int) ->Int{
        let (_,m,_) = convertTime(seconds: seconds)
        return m
    }
    
    func returnSecs(seconds: Int) -> Int{
        let (_,_,s) = convertTime(seconds: seconds)
        return s
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //configure the destination view controller only when save button is pressed
        guard let button = sender as? UIButton, button === saveButton else{
            os_log("Save not pressed; canceling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let brewtime = getBrewTime()
        
        tea = Tea(name: name, brewtime: brewtime)
        
    }
 
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide the keyboard
        nameTextField.resignFirstResponder()
        saveButton.isHidden = false
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        updateSaveButtonState()
        textField.resignFirstResponder()
        saveButton.isHidden = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // disable save button while editing
        
        saveButton.isEnabled = false
        saveButton.isHidden = true
        saveButton.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.1)
        
        if textField == brewTimeField{
            self.view.endEditing(true)
            saveButton.isHidden = true
            timePicker.isHidden = false
        }
        
        if textField == nameTextField{
            timePicker.isHidden = true
            saveButton.isHidden = true 
        }
    }
    
    // MARK: UIPickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return timeData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        brewTimeField.resignFirstResponder()
        updateLabel()
        
        timePicker.view(forRow: row, forComponent: component)?.backgroundColor = UIColor.darkGray
        //view(forRow: row, forComponent: component)?.backgroundColor = UIColor.darkGray
        
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let tData = timeData[component][row]

        let timeText = NSAttributedString(string: tData, attributes: [NSAttributedString.Key.font:UIFont(name: "Montserrat-Light", size: 12.0)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        
        return timeText
    }
    
    // update the brew time text field once user chooses time in picker 
    func updateLabel(){
        let mins = timeData[minComponent][timePicker.selectedRow(inComponent: minComponent)]
        let secs = timeData[secComponent][timePicker.selectedRow(inComponent: secComponent)]
        brewTimeField.text = mins + "m " + secs + "s "
    }
    
    func getBrewTime()-> Int{
        let mins = timeData[minComponent][timePicker.selectedRow(inComponent: minComponent)]
        let secs = timeData[secComponent][timePicker.selectedRow(inComponent: secComponent)]
        
        let m:Int? = Int(mins)
        let s:Int? = Int(secs)
        
        brewTimeInSecs = (60 * m!) + s!
        //print("Brew Time in seconds: \(brewTimeInSecs)")
    
        return brewTimeInSecs
    }
    
    // MARK: Private Methods
    private func updateSaveButtonState(){
        // disable the save button if text field is empty
        let text = nameTextField.text ?? ""
  
        saveButton.isEnabled = !text.isEmpty

        if saveButton.isEnabled == true{
            saveButton.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.5)
        }
        else{
            saveButton.backgroundColor = UIColor(red: 145/255, green: 189/255, blue: 167/255, alpha: 0.1)
        }
    }
}
