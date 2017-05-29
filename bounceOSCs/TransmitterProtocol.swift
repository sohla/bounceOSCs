//
//  TransmitterProtocol.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 29/5/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import Foundation

protocol TransmitterProtocol {
    func transmit(sensor: SensorProtocol)
}
