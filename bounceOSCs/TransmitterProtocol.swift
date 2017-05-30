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
    func transmit(sensor: SensorProtocol)
}

struct OSCTransmitter : TransmitterProtocol {
   
    static let client:OSCClient = OSCClient();

    func transmit(sensor: SensorProtocol){
        
        let head:String = "udp://";
        let address:String = "169.254.222.238";
        let port:String = ":57120";
        
        let msg:OSCMessage = OSCMessage(address: sensor.oscData().0, arguments: sensor.oscData().1);
        OSCTransmitter.client.send(msg, to: head+address+port);
    }
}
