//
//  FirstViewController.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 24/5/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import UIKit
import MMLanScan

class FirstViewController: UIViewController, MMLANScannerDelegate {

    
    
    var lanScanner : MMLANScanner!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.lanScanner = MMLANScanner(delegate:self)
        lanScanner.start()
        
        let stA = SensorTransmitter(sensor: AttitudeSensor(), transmitter: OSCTransmitter())
        let stB = SensorTransmitter(sensor: AccelSensor(), transmitter: OSCTransmitter())
        let stC = SensorTransmitter(sensor: RotationRateSensor(), transmitter: OSCTransmitter())
        
        stA.run(interval:0.03)
        stB.run(interval:0.03)
        stC.run(interval:0.03)

        let stE = SensorTransmitter(sensor:AudioAmpSensor(), transmitter: OSCTransmitter())
        stE.run(interval:0.4)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //
    
    func lanScanDidFindNewDevice(_ device: Device!){
        
        print("new device found at : \(device.ipAddress)")
        
    }
    func lanScanDidFinishScanning(with status: MMLanScannerStatus){
        
    }
    func lanScanProgressPinged(_ pingedHosts: Float, from overallHosts: Int){
        print("scanning \(pingedHosts / Float(overallHosts)*100)%")
        
    }
    func lanScanDidFailedToScan(){
        
    }


}

