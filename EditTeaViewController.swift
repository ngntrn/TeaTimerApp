//
//  EditTeaViewController.swift
//  TeaTimer
//
//  Created by Lucky Tran  on 10/5/18.
//  Copyright © 2018 Ngan Tran. All rights reserved.
//

import UIKit
import os.log


class EditTeaViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var brewTimeField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var timePicker: UIPickerView! = UIPickerView()
    
    
    // MARK: Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    var tea: Tea?
    
    var toPass: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        nameTextField.text = toPass
        nameTextField.delegate = self
        
        
        // enable save button only if text field has input
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //configure the desitnation view controller only when save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
            os_log("Save not pressed; canceling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let brewtime = 30
        
        tea = Tea(name: name, brewtime: brewtime)
        
    }
 
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // disable save button while editing
        saveButton.isEnabled = false
    }
    
    // MARK: Private Methods
    private func updateSaveButtonState(){
        // disable the save button if text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        
    }

}
