//
//  SensorTransmitter.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 29/5/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import Foundation

class SensorTransmitter {
    
    var sensor: SensorProtocol?
    var transmitter: TransmitterProtocol?
    weak var timer: Timer?
    
    
    init(sensor: SensorProtocol,transmitter: TransmitterProtocol){
        self.sensor = sensor;
        self.transmitter = transmitter;
    }
    
    @objc func next(){
        transmitter?.transmit(sensor: sensor!)
    }
    func run(interval:Double = 0.03) {
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(next), userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer?.invalidate()
    }
    
    deinit {
        stop()
    }
}

