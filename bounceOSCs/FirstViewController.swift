//
//  FirstViewController.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 24/5/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController, TransmitterProtocol {

    
    @IBOutlet weak var levelView: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        levelView.layer.frame = levelView.layer.frame.insetBy(dx: 0, dy: -10.0)
        
        let stA = SensorTransmitter(sensor: AttitudeSensor(), transmitter: OSCTransmitter())
        let stB = SensorTransmitter(sensor: AccelSensor(), transmitter: OSCTransmitter())
        let stC = SensorTransmitter(sensor: RotationRateSensor(), transmitter: OSCTransmitter())
        
        stA.run(interval:0.03)
        stB.run(interval:0.03)
        stC.run(interval:0.03)

        let stD = SensorTransmitter(sensor:AudioAmpSensor(), transmitter: self)
        stD.run(interval:0.03)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onConnectionTouchUp(_ sender: Any) {

    }
    
    func transmit(sensor: SensorProtocol){
        
        levelView.progress = Float(sensor.getData()[0]*100)
    }

}

