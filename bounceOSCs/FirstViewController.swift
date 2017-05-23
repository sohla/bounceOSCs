//
//  FirstViewController.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 24/5/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import UIKit

import OSCKit

class FirstViewController: UIViewController {

    let client:OSCClient = OSCClient();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let head:String = "udp://";
        let address:String = "localhost";
        let port:String = ":9000";
        
        let msg:OSCMessage = OSCMessage(address: "/hello", arguments: ["world","u","r","awsum"]);
        client.send(msg, to: head+address+port);
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onConnectionTouchUp(_ sender: Any) {
    }
}

