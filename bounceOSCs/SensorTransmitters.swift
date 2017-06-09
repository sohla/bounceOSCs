//
//  SensorTransmitters.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 29/5/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import Foundation
import Pantry

class SensorTransmitters {
    
    
    let attitudeOSC = SensorTransmitter(
        sensor: AttitudeSensor(),
        transmitter: OSCTransmitter(
            netAddress: NetAddress(address: "127.0.0.1", port: "9000"), isOn: false))
    
    let accelOSC = SensorTransmitter(
        sensor: AccelSensor(),
        transmitter: OSCTransmitter(
            netAddress: NetAddress(address: "127.0.0.1", port: "9000"), isOn: false))

    let rotationOSC = SensorTransmitter(
        sensor: RotationRateSensor(),
        transmitter: OSCTransmitter(
            netAddress: NetAddress(address: "127.0.0.1", port: "9000"), isOn: false))

    let ampOSC = SensorTransmitter(
        sensor: AudioAmpSensor(),
        transmitter: OSCTransmitter(
            netAddress: NetAddress(address: "127.0.0.1", port: "9000"), isOn: false))

    
    
    init() {

        if let ipAddress: String = Pantry.unpack("ip_address"),
            let port: String = Pantry.unpack("port"),
            let isOn: Bool = Pantry.unpack("OSC") {
            
                let na = NetAddress(address: ipAddress, port: port)
            
                self.attitudeOSC.transmitter = OSCTransmitter(netAddress: na, isOn: isOn)
                self.accelOSC.transmitter = OSCTransmitter(netAddress: na, isOn: isOn)
                self.rotationOSC.transmitter = OSCTransmitter(netAddress: na, isOn: isOn)
                self.ampOSC.transmitter = OSCTransmitter(netAddress: na, isOn: isOn)
        }
        
        if let on: Bool = Pantry.unpack("Gyroscope") {
            self.attitudeOSC.transmitter?.isOn = on
        }

        if let on: Bool = Pantry.unpack("Accelerometer") {
            self.accelOSC.transmitter?.isOn = on
        }

        if let on: Bool = Pantry.unpack("RotationRate") {
            self.rotationOSC.transmitter?.isOn = on
        }

        if let on: Bool = Pantry.unpack("Amp") {
            self.ampOSC.transmitter?.isOn = on
        }

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "ip_address"), object: nil, queue: nil) { n in
            let ip = n.userInfo?["value"] as? String

            self.attitudeOSC.transmitter?.netAddress.address = ip!
            self.accelOSC.transmitter?.netAddress.address = ip!
            self.rotationOSC.transmitter?.netAddress.address = ip!
            self.ampOSC.transmitter?.netAddress.address = ip!
        }
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "port"), object: nil, queue: nil) { n in
            let port = n.userInfo?["value"] as? String

            self.attitudeOSC.transmitter?.netAddress.port = port!
            self.accelOSC.transmitter?.netAddress.port = port!
            self.rotationOSC.transmitter?.netAddress.port = port!
            self.ampOSC.transmitter?.netAddress.port = port!
        }

        
        
        
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "OSC_onOffChanged"), object: nil, queue: nil) { n in
            print(n.userInfo!)
            
            let value = n.userInfo?["value"] as? Bool
            
            if(value!){
                self.attitudeOSC.run(interval: 0.3)
                self.accelOSC.run(interval: 0.3)
                self.rotationOSC.run(interval: 0.3)
                self.ampOSC.run(interval: 0.3)
            }else{
                self.attitudeOSC.stop()
                self.accelOSC.stop()
                self.rotationOSC.stop()
                self.ampOSC.stop()
            }
            
        }

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Gyroscope_onOffChanged"), object: nil, queue: nil) { n in
            let value = n.userInfo?["value"] as? Bool
            self.attitudeOSC.transmitter?.isOn = value!
        }

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Accelerometer_onOffChanged"), object: nil, queue: nil) { n in
            let value = n.userInfo?["value"] as? Bool
            self.accelOSC.transmitter?.isOn = value!
        }

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "RotationRate_onOffChanged"), object: nil, queue: nil) { n in
            let value = n.userInfo?["value"] as? Bool
            self.rotationOSC.transmitter?.isOn = value!
        }

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Amp_onOffChanged"), object: nil, queue: nil) { n in
            let value = n.userInfo?["value"] as? Bool
            self.ampOSC.transmitter?.isOn = value!
        }

        
    }
}


