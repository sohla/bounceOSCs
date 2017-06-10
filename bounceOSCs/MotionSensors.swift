//
//  MotionSensors.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 29/5/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import Foundation
import CoreMotion

//• argh for now global
let motionManager: CMMotionManager = CMMotionManager()

class MotionSensor {
    
    
    init() {
        
        motionManager.deviceMotionUpdateInterval = 0.03
        
        if(motionManager.isDeviceMotionAvailable){
            motionManager.startDeviceMotionUpdates()
        }
        
    }
    
}

class RotationRateSensor : MotionSensor, SensorProtocol {
    
    func getData() -> Array<Double> {
        
        if((motionManager.deviceMotion) != nil){
            let rotationRate: CMRotationRate = (motionManager.deviceMotion?.rotationRate)!
            return [rotationRate.x,rotationRate.y,rotationRate.z]
        }
        return [0]
    }
    
    func oscData() -> (String,Array<String>){
        let arrayString: Array<String> = getData().flatMap { String($0) }
        return ("/gyrosc/rrate",arrayString)
        
    }
    func midiData() -> String{ return "cc51:1 \(getData()[0]) cc51:2 \(getData()[1])"}
    
}

class AttitudeSensor : MotionSensor, SensorProtocol {
    
    func getData() -> Array<Double> {
        
        if((motionManager.deviceMotion) != nil){
            let attitude: CMAttitude = (motionManager.deviceMotion?.attitude)!
            return [attitude.pitch,attitude.roll,attitude.yaw]
        }
        return [0]
    }
    
    func oscData() -> (String,Array<String>){
        let arrayString: Array<String> = getData().flatMap { String($0) }
        return ("/gyrosc/gyro",arrayString)
    
    }
    func midiData() -> String{ return "cc51:1 \(getData()[0]) cc51:2 \(getData()[1])"}
    
}

class AccelSensor : MotionSensor, SensorProtocol {
    
    func getData() -> Array<Double> {
        
        if((motionManager.deviceMotion) != nil){
            let accel: CMAcceleration = (motionManager.deviceMotion?.userAcceleration)!
            return [accel.x,accel.y,accel.z]
        }
        return [0]
    }
    
    func oscData() -> (String,Array<String>){
        let arrayString: Array<String> = getData().flatMap { String($0) }
        return ("/gyrosc/accel",arrayString)
        
    }
    func midiData() -> String{ return "cc51:1 \(getData()[0]) cc51:2 \(getData()[1])"}
    
}


//struct Gyro : SensorProtocol {
//    
//    func getData() -> Array<Double> { return [0.1,0.3] }
//    
//    func oscData() -> String{ return "/gyro/ \(getData())"}
//    func midiData() -> String{ return "cc1:1 \(getData()[0]) cc1:2 \(getData()[1])"}
//    
//}
//struct Accel : SensorProtocol {
//    
//    func getData() -> Array<Double> { return [Double(arc4random_uniform(100)),0.99] }
//    
//    func oscData() -> String{ return "/accel/ \(getData())"}
//    func midiData() -> String{ return "cc51:1 \(getData()[0]) cc51:2 \(getData()[1])"}
//    
//}
//
//
//struct Seconds : SensorProtocol {
//    
//    let today:Date = Calendar.current.startOfDay(for:Date())
//    
//    func getData() -> Array<Double>{
//        
//        let d:Double = Date().timeIntervalSince(today)
//        
//        return [Double(d)]
//    }
//    
//    func oscData() -> String{
//        return "Todays Time -> \(getData()[0]) secs"
//    }
//    func midiData() -> String{
//        return "MIDITime ->\(getData()[0])"
//    }
//    
//}

