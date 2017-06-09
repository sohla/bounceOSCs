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
    var address:String
    var port:String
    
    func asString() -> String {
        let head:String = "udp://";
        return head+address+":"+port
    }
}

struct OSCTransmitter : TransmitterProtocol {
   
    static let client:OSCClient = OSCClient()
    var netAddress:NetAddress
    var isOn: Bool
    
    func transmit(sensor: SensorProtocol){
        if(isOn){
            let msg:OSCMessage = OSCMessage(address: sensor.oscData().0, arguments: sensor.oscData().1)
            OSCTransmitter.client.send(msg, to: netAddress.asString())
        }
    }
}
