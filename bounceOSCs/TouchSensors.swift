//
//  TouchSensors.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 14/6/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import Foundation

class ButtonSensor :  SensorProtocol {

    var value: Double = 0.0
    
    init() {
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Button_touched"), object: nil, queue: nil) { n in
            self.value = n.userInfo?["value"] as! Double
        }
    }
    func getData() -> Array<Double> {
        
        return [self.value]
    }
    
    func oscData() -> (String,Array<String>){
        let arrayString: Array<String> = getData().flatMap { String($0) }
        return ("/gyrosc/button",arrayString)
        
    }
    func midiData() -> String{ return "cc51:1 \(getData()[0]) cc51:2 \(getData()[1])"}
}

class SliderSensor :  SensorProtocol {
    
    var value: Double = 0.0
    
    init() {
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Slider_changed"), object: nil, queue: nil) { n in
            self.value = n.userInfo?["value"] as! Double
        }
    }
    func getData() -> Array<Double> {
        
        return [self.value]
    }
    
    func oscData() -> (String,Array<String>){
        let arrayString: Array<String> = getData().flatMap { String($0) }
        return ("/gyrosc/slider",arrayString)
        
    }
    func midiData() -> String{ return "cc51:1 \(getData()[0]) cc51:2 \(getData()[1])"}
}
