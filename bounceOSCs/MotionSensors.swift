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
var motionManager: CMMotionManager?
var referenceAttitude: CMAttitude?

class MotionSensor {

    init() {

        reset()
        
    }
    func bootMotionManager() {
        
        if motionManager == nil {
            motionManager = CMMotionManager()
        }

        motionManager?.deviceMotionUpdateInterval = 0.03
        motionManager?.startDeviceMotionUpdates()

    }
    
    func killMotionManager(){

        referenceAttitude = nil
        
        if motionManager != nil {
            motionManager?.stopDeviceMotionUpdates()
            motionManager = nil
        }
    }
    func reset() {
        
        killMotionManager()

        bootMotionManager()

        // block and wait for device to wake up
        while((motionManager?.deviceMotion) == nil){
            print("waiting for device..")
        }
        referenceAttitude = motionManager?.deviceMotion?.attitude
        print("device reference attitude \(referenceAttitude?.quaternion) set.")
    
    }
    
    func getAttitude() -> CMAttitude? {
        
        if(referenceAttitude != nil) {
            motionManager?.deviceMotion?.attitude.multiply(byInverseOf: referenceAttitude!)
        }
        return motionManager?.deviceMotion?.attitude
    }
}


class RotationRateSensor : MotionSensor, SensorProtocol {
    
    func getData() -> Array<Double> {
        
        if((motionManager?.deviceMotion) != nil){
            let rotationRate: CMRotationRate = (motionManager!.deviceMotion?.rotationRate)!
            return [rotationRate.x,rotationRate.y,rotationRate.z]
        }
        return [0]
    }
    
    func oscData() -> (String,Array<String>){
        let arrayString: Array<String> = getData().compactMap { String($0) }
        return ("/gyrosc/rrate",arrayString)
        
    }
    func midiData() -> String{ return "cc51:1 \(getData()[0]) cc51:2 \(getData()[1])"}//•
    
}

class AttitudeSensor : MotionSensor, SensorProtocol {
    
    
    func getData() -> Array<Double> {
        
        if((motionManager?.deviceMotion) != nil){
            let attitude: CMAttitude = getAttitude()!//(motionManager.deviceMotion?.attitude)!
            return [attitude.pitch,attitude.roll,attitude.yaw]
        }
        return [0]
    }
    
    func oscData() -> (String,Array<String>){
        let arrayString: Array<String> = getData().compactMap { String($0) }
        return ("/gyrosc/gyro",arrayString)
    
    }
    func midiData() -> String{ return "cc51:1 \(getData()[0]) cc51:2 \(getData()[1])"}//•
    
}

class RotationMatrixSensor : MotionSensor, SensorProtocol {
    
    func getData() -> Array<Double> {
        
        if((motionManager?.deviceMotion) != nil){
            let attitude: CMAttitude = getAttitude()!//(motionManager.deviceMotion?.attitude)!
            let m: CMRotationMatrix = attitude.rotationMatrix
            //print([attitude.pitch,attitude.roll,attitude.yaw].map{$0 * (180.0 / Double.pi) + 180.0})
            return([m.m11,m.m12,m.m13,0,
                    m.m21,m.m22,m.m23,0,
                    m.m31,m.m32,m.m33,0,
                    0,0,0,1
                ])
        }
        return [0]
    }
    
    func oscData() -> (String,Array<String>){
        let arrayString: Array<String> = getData().compactMap { String($0) }
        return ("/gyrosc/rotmat",arrayString)
        
    }
    func midiData() -> String{ return "TO \(getData()[0]) DO \(getData()[1])"}//•
    
}

class AccelSensor : MotionSensor, SensorProtocol {
    
    func getData() -> Array<Double> {
        
        if((motionManager?.deviceMotion) != nil){
            let accel: CMAcceleration = (motionManager!.deviceMotion?.userAcceleration)!
            return [accel.x,accel.y,accel.z]
        }
        return [0]
    }
    
    func oscData() -> (String,Array<String>){
        let arrayString: Array<String> = getData().compactMap { String($0) }
        return ("/gyrosc/accel",arrayString)
        
    }
    func midiData() -> String{ return "cc51:1 \(getData()[0]) cc51:2 \(getData()[1])"}//•
    
}


class QuaternionSensor : MotionSensor, SensorProtocol {
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "motionReset"), object: nil, queue: nil) { n in
            self.reset()
        }
        
    }

    func getData() -> Array<Double> {
        
        if((motionManager?.deviceMotion) != nil){
            let attitude: CMAttitude = getAttitude()!//(motionManager.deviceMotion?.attitude)!
            let q: CMQuaternion = attitude.quaternion
            return [q.w,q.x,q.y,q.z]
        }
        return [0]
    }
    
    func oscData() -> (String,Array<String>){
        let arrayString: Array<String> = getData().compactMap { String($0) }
        return ("/gyrosc/quat",arrayString)
        
    }
    func midiData() -> String{ return "cc51:1 \(getData()[0]) cc51:2 \(getData()[1])"}//•
    
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

