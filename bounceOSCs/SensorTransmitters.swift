//
//  SensorTransmitters.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 29/5/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import Foundation


class SensorTransmitters {
    
    
    //let netAddress:NetAddress = NetAddress(address: "127.0.0.1", port: "57210")

    let attitudeOSC = SensorTransmitter(
                            sensor: AttitudeSensor(),
                            transmitter: OSCTransmitter(
                                netAddress: NetAddress(address: "127.0.0.1", port: "9000"), isOn: false))
    
    
    init() {

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "OSC_onOffChanged"), object: nil, queue: nil) { n in
            print(n.userInfo!)
            
            let value = n.userInfo?["value"] as? Bool
            
            if(value!){
                self.attitudeOSC.run(interval: 0.3)
            }else{
                self.attitudeOSC.stop()
            }
            
        }

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Gyroscope_onOffChanged"), object: nil, queue: nil) { n in
            let value = n.userInfo?["value"] as? Bool
            self.attitudeOSC.transmitter?.isOn = value!
        }
        
        
    }
}


