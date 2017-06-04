//
//  OSCViewController.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 3/6/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import UIKit

class OSCViewController: UIViewController {

    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var ipAddressTextField: UITextField!
    
    let ipAddressDelegate = ipAddressTextFieldDelegate()
    let portDelegate = portTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ipAddressTextField.delegate = ipAddressDelegate
        portTextField.delegate = portDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setipAddressTextField(_ s:String){
        ipAddressTextField.text = s
        //• save this update
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

    
    @IBAction func onOffButton(_ sender: Any) {
    }
}


class ipAddressTextFieldDelegate : NSObject, UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(isValidIP(s: textField.text!)){
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

    }
    func isValidIP(s: String) -> Bool {
        let parts = s.components(separatedBy: ".")
        let nums = parts.flatMap { Int($0) }
        return parts.count == 4 && nums.count == 4 && nums.filter { $0 >= 0 && $0 < 256}.count == 4
    }
    
}


class portTextFieldDelegate : NSObject, UITextFieldDelegate {
    
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

    }
    func isValidPort(s: String) -> Bool {
        if let _ = UInt16(s) { return true }
        return false
    }
    
}

