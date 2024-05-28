//
//  RXOSCViewController.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 27/11/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import UIKit
//import Pantry

class RXOSCViewController: UIViewController {
    
    @IBOutlet weak var rxportTextField: UITextField!
    
    let rxportDelegate = rxportTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rxportTextField.delegate = rxportDelegate
        
        if let str = UserDefaults.standard.string(forKey: UserSettings.receivePort) {
            rxportTextField.text = str
        }

        
        //        ipAddressTextField.keyboardType = UIKeyboardType.numberPad
        //        portTextField.keyboardType = UIKeyboardType.numberPad
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func unwindFromModalViewController(_ segue: UIStoryboardSegue){
        
    }
    
    
}


class rxportTextFieldDelegate : NSObject, UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(isValidPort(s: textField.text!)){
            textField.resignFirstResponder()
            return true
        }
        return false
        
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //• save this update
        if(isValidPort(s: textField.text!)){
            save(textField.text!)
        }
    }

    func isValidPort(s: String) -> Bool {
        if let _ = UInt16(s) { return true }
        return false
    }

    func save(_ s: String) {
        
        UserDefaults.standard.set(s, forKey: UserSettings.receivePort)
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: UserSettings.receivePort),
            object: nil,
            userInfo: ["value": s])
    }
    
}

