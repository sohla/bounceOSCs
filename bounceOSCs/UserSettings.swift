//
//  UserSettings.swift
//  bounceOSCs
//
//  Created by soh_la on 28/5/2024.
//  Copyright © 2024 Stephen OHara. All rights reserved.
//

import Foundation

// also used for notifications

enum UserSettings {
    static let transmitIP = "tx_ip"
    static let transmitPort = "tx_port"
    static let receiveIP = "rx_ip"
    static let receivePort = "rx_port"

    static let gyroscopeOn = "gyroscope_on"
    static let rotationMatrixOn = "rotatioMatrix_on"
    static let accelerometerOn = "accelerometer_on"
    static let rotationOn = "rotationRate_on"
    static let quaternionOn = "quaternion_on"

}
