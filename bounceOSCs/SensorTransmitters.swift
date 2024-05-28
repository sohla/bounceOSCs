//
//  SensorTransmitters.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 29/5/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import Foundation
//import Pantry

class SensorTransmitters {
    
    
    let attitudeOSC = SensorTransmitter(
        sensor: AttitudeSensor(),
        transmitter: OSCTransmitter())

    let rotationMatrixOSC = SensorTransmitter(
        sensor: RotationMatrixSensor(),
        transmitter: OSCTransmitter())

    let accelOSC = SensorTransmitter(
        sensor: AccelSensor(),
        transmitter: OSCTransmitter())

    let rotationOSC = SensorTransmitter(
        sensor: RotationRateSensor(),
        transmitter: OSCTransmitter())

    let quaternionOSC = SensorTransmitter(
        sensor: QuaternionSensor(),
        transmitter: OSCTransmitter())

//    let ampOSC = SensorTransmitter(
//        sensor: AudioAmpSensor(),
//        transmitter: OSCTransmitter())

    let buttonOSC = SensorTransmitter(
        sensor: ButtonSensor(),
        transmitter: OSCTransmitter())

    let sliderOSC = SensorTransmitter(
        sensor: SliderSensor(),
        transmitter: OSCTransmitter())
    
    
    init() {

        if let ipAddress = UserDefaults.standard.string(forKey: UserSettings.transmitIP) {
            if let port = UserDefaults.standard.string(forKey: UserSettings.transmitPort) {
                
                let na = NetAddress(address: ipAddress, port: port)
                
                self.attitudeOSC.transmitter = OSCTransmitter(netAddress: na, isOn: false)
                self.rotationMatrixOSC.transmitter = OSCTransmitter(netAddress: na, isOn: false)
                self.accelOSC.transmitter = OSCTransmitter(netAddress: na, isOn: false)
                self.rotationOSC.transmitter = OSCTransmitter(netAddress: na, isOn: false)
                self.quaternionOSC.transmitter = OSCTransmitter(netAddress: na, isOn: false)
                //self.ampOSC.transmitter = OSCTransmitter(netAddress: na, isOn: false)
                self.buttonOSC.transmitter = OSCTransmitter(netAddress: na, isOn: true)
                self.sliderOSC.transmitter = OSCTransmitter(netAddress: na, isOn: true)
            }
        }
        

        self.attitudeOSC.transmitter?.isOn = UserDefaults.standard.bool(forKey: UserSettings.gyroscopeOn)
        self.rotationMatrixOSC.transmitter?.isOn = UserDefaults.standard.bool(forKey: UserSettings.rotationMatrixOn)
        self.accelOSC.transmitter?.isOn = UserDefaults.standard.bool(forKey: UserSettings.accelerometerOn)
        self.rotationOSC.transmitter?.isOn = UserDefaults.standard.bool(forKey: UserSettings.rotationOn)
        self.quaternionOSC.transmitter?.isOn = UserDefaults.standard.bool(forKey: UserSettings.quaternionOn)
        

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "ip_address"), object: nil, queue: nil) { n in
            let ip = n.userInfo?["value"] as? String

            self.attitudeOSC.transmitter?.netAddress.address = ip!
            self.rotationMatrixOSC.transmitter?.netAddress.address = ip!
            self.accelOSC.transmitter?.netAddress.address = ip!
            self.rotationOSC.transmitter?.netAddress.address = ip!
            self.quaternionOSC.transmitter?.netAddress.address = ip!
//            self.ampOSC.transmitter?.netAddress.address = ip!
            self.buttonOSC.transmitter?.netAddress.address = ip!
            self.sliderOSC.transmitter?.netAddress.address = ip!
        }
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "txport"), object: nil, queue: nil) { n in
            let port = n.userInfo?["value"] as? String

            self.attitudeOSC.transmitter?.netAddress.port = port!
            self.rotationMatrixOSC.transmitter?.netAddress.port = port!
            self.accelOSC.transmitter?.netAddress.port = port!
            self.rotationOSC.transmitter?.netAddress.port = port!
            self.quaternionOSC.transmitter?.netAddress.port = port!
//            self.ampOSC.transmitter?.netAddress.port = port!
            self.buttonOSC.transmitter?.netAddress.port = port!
            self.sliderOSC.transmitter?.netAddress.port = port!
        }

         NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "TX OSC_onOffChanged"), object: nil, queue: nil) { n in
            
            let value = n.userInfo?["value"] as? Bool
             let framerate = 1.0 / 12.0
             
            if(value!){
                self.attitudeOSC.run(interval: framerate)
                self.rotationMatrixOSC.run(interval: framerate)
                self.accelOSC.run(interval: framerate)
                self.rotationOSC.run(interval: framerate)
                self.quaternionOSC.run(interval: framerate)
//                self.ampOSC.run(interval: framerate)
                
                // if we want to poll use run
                //self.buttonOSC.run(interval: framerate)
                
                self.buttonOSC.transmitter?.isOn = true
                self.sliderOSC.transmitter?.isOn = true
                
            }else{
                self.attitudeOSC.stop()
                self.rotationMatrixOSC.stop()
                self.accelOSC.stop()
                self.rotationOSC.stop()
                self.quaternionOSC.stop()
//                self.ampOSC.stop()
                self.buttonOSC.transmitter?.isOn = false
                self.sliderOSC.transmitter?.isOn = false
            }
            
        }

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Gyroscope_onOffChanged"), object: nil, queue: nil) { n in
            let value = n.userInfo?["value"] as? Bool
            self.attitudeOSC.transmitter?.isOn = value!
            //if value! {(self.attitudeOSC.sensor as! MotionSensor).reset()}
        }

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "RotationMatrix_onOffChanged"), object: nil, queue: nil) { n in
            let value = n.userInfo?["value"] as? Bool
            self.rotationMatrixOSC.transmitter?.isOn = value!
            //if value! {(self.attitudeOSC.sensor as! MotionSensor).reset()}
        }

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Accelerometer_onOffChanged"), object: nil, queue: nil) { n in
            let value = n.userInfo?["value"] as? Bool
            self.accelOSC.transmitter?.isOn = value!
        }

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "RotationRate_onOffChanged"), object: nil, queue: nil) { n in
            let value = n.userInfo?["value"] as? Bool
            self.rotationOSC.transmitter?.isOn = value!
        }

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Quaternion_onOffChanged"), object: nil, queue: nil) { n in
            let value = n.userInfo?["value"] as? Bool
            self.quaternionOSC.transmitter?.isOn = value!
        }

//        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Amp_onOffChanged"), object: nil, queue: nil) { n in
//            let value = n.userInfo?["value"] as? Bool
////            self.ampOSC.transmitter?.isOn = value!
//        }

        
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Button_touched"), object: nil, queue: nil) { n in
            // if we don't want to poll, respond via notification and send once
            self.buttonOSC.next()
        }
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Slider_changed"), object: nil, queue: nil) { n in
            self.sliderOSC.next()
        }

        
    }
}


