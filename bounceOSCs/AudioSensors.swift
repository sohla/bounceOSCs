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
    let bufferSize: UInt32 = 1_024

    
    init() {

        AKSettings.audioInputEnabled = true
        AKSettings.bufferLength = .veryShort
        
        mic = AKMicrophone()
        
        tracker = AKAmplitudeTracker.init(mic)
        silence = AKBooster(tracker, gain: 0)
        
//        AudioKit.output = silence
//        try? AudioKit.start()
//        tracker.start()

    }
    
    func trigger(_ sum: Float){
        print("*",sum)
    }
}


class AudioAmpSensor : AudioSensor, SensorProtocol {
    
    func getData() -> Array<Double> {
        return [tracker.amplitude]
    }
    
    func oscData() -> (String,Array<String>){
        let amp = tracker.amplitude 
        
//        if tracker.amplitude > 0.01 {
//            print(tracker.amplitude)
//        }
        return ("/gyrosc/amp",[String(amp)])
    }
    func midiData() -> String{ return "TODO"}
    
}
