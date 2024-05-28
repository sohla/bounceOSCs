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
    
    let audioEngine = AudioEngine()
    let mic: AudioEngine.InputNode
    let ampTap: AmplitudeTap

    init() {
        mic = audioEngine.input!
        ampTap = AmplitudeTap(mic)
        ampTap.analysisMode = .peak
        audioEngine.output = mic
        audioEngine.mainMixerNode?.volume = 0.0
        ampTap.start()
        mic.start()
        try? audioEngine.start()
        
        
    }
    
    func trigger(_ sum: Float){
        print("*",sum)
    }
}


class AudioAmpSensor : AudioSensor, SensorProtocol {

    override init() {
    }

    func getData() -> Array<Double> {
        return [0.0]
    }
    
    func oscData() -> (String,Array<String>){
        let amp = ampTap.amplitude
        print(amp)
        return ("/gyrosc/amp",[String(amp)])
    }
    func midiData() -> String{ return "TODO"}
    
}
