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

    static let gyroscopeOn = "Gyroscope"
    static let rotationMatrixOn = "RotationMatrix"
    static let accelerometerOn = "Accelerometer"
    static let rotationOn = "RotationRate"
    static let quaternionOn = "Quaternion"

}
