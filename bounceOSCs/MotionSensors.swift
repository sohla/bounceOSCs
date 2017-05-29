//
//  MotionSensors.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 29/5/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import Foundation


struct Gyro : SensorProtocol {
    
    func getData() -> Array<Float> { return [0.1,0.3] }
    
    func oscData() -> String{ return "/gyro/ \(getData())"}
    func midiData() -> String{ return "cc1:1 \(getData()[0]) cc1:2 \(getData()[1])"}
    
}
struct Accel : SensorProtocol {
    
    func getData() -> Array<Float> { return [Float(arc4random_uniform(100)),0.99] }
    
    func oscData() -> String{ return "/accel/ \(getData())"}
    func midiData() -> String{ return "cc51:1 \(getData()[0]) cc51:2 \(getData()[1])"}
    
}

struct Seconds : SensorProtocol {
    
    let today:Date = Calendar.current.startOfDay(for:Date())
    
    func getData() -> Array<Float>{
        
        let d:Double = Date().timeIntervalSince(today)
        
        return [Float(d)]
    }
    
    func oscData() -> String{
        return "Todays Time -> \(getData()[0]) secs"
    }
    func midiData() -> String{
        return "MIDITime ->\(getData()[0])"
    }
    
}

