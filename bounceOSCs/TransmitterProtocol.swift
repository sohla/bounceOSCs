//
//  TransmitterProtocol.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 29/5/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import Foundation
import OSCKit

protocol TransmitterProtocol {
    var isOn: Bool {get set}
    var netAddress:NetAddress {get set}
    func transmit(sensor: SensorProtocol)
}

struct NetAddress {
    var address:String = "127.0.0.1"
    var port:String = "57120"
    
    
    func asString() -> String {
        let head:String = "udp://";
        return head+address+":"+port
    }
}


// WHAT THE HELL WERE YOU THINKING. THIS iS THE WORST FIXXXXX!!!!!!
//

struct OSCTransmitter : TransmitterProtocol {
   
    static let client:OSCClient = OSCClient()
    var netAddress:NetAddress = NetAddress()
    var isOn: Bool = false
    
    func transmit(sensor: SensorProtocol){
        if(isOn){
            let data = sensor.oscData()
            let msg = OSCMessage(data.0, values: data.1)
            if let ip = UserDefaults.standard.string(forKey: UserSettings.transmitIP) {
                if let port = UserDefaults.standard.string(forKey: UserSettings.transmitPort) {
                    if let portInt = UInt16(port) {
                        try? OSCTransmitter.client.send(msg, to: ip, port: portInt)
                    }
                }
            }


        }else{
            //print("OSC Transmitter is OFF.")
        }
    }
}
