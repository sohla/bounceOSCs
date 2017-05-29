//
//  SensorProtocol.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 29/5/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import Foundation

protocol SensorProtocol {
    
    func getData() -> Array<Double>
    
    func oscData() -> (String,Array<String>)
    func midiData() -> String
}
