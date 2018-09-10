//
//  AudioSensors.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 30/5/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import Foundation
import AudioKit

class AudioSensor {
    
    let mic: AKMicrophone!
    let tracker: AKAmplitudeTracker!
    let silence: AKBooster!

    init() {
        AKSettings.audioInputEnabled = true
        mic = AKMicrophone()
        tracker = AKAmplitudeTracker(mic)
        silence = AKBooster(tracker, gain: 0)

        AudioKit.output = silence
        try? AudioKit.start()

    }
}


class AudioAmpSensor : AudioSensor, SensorProtocol {
    
    func getData() -> Array<Double> {
        return [tracker.amplitude]
    }
    
    func oscData() -> (String,Array<String>){
        let amp = tracker.amplitude * 1024
        return ("/gyrosc/amp",[String(amp)])
    }
    func midiData() -> String{ return "TODO"}
    
}
