//
//  AudioSensors.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 30/5/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import Foundation
import AudioKit

import CoreMIDI
import Haptica

class AudioSensor : MIDIListener {
    
    
    
//    let audioEngine = AudioEngine()
//    let mic: AudioEngine.InputNode
//    let ampTap: AmplitudeTap
    
    
    //    let midiManager = MIDIManager(clientName: "oscBounces", model: "iphone", manufacturer: "sohla")
    init() {
//        mic = audioEngine.input!
//        ampTap = AmplitudeTap(mic)
//        ampTap.analysisMode = .peak
//        audioEngine.output = mic
//        audioEngine.mainMixerNode?.volume = 0.0
//        ampTap.start()
//        mic.start()
//        try? audioEngine.start()
        //        try?midiManager.start()
        
        let midi = MIDI.sharedInstance
        print(midi.inputNames)
        midi.openInput()
        midi.addListener(self)
        
        
        
    }
    
    func trigger(_ sum: Float){
        print("*",sum)
    }
    
    func receivedMIDINoteOn(noteNumber: AudioKit.MIDINoteNumber, velocity: AudioKit.MIDIVelocity, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
        print("midi note on: \(noteNumber) velocity: \(velocity) channel: \(channel)")
        
        Haptic.impact(.heavy).generate()
    }
    

    
    func receivedMIDINoteOff(noteNumber: AudioKit.MIDINoteNumber, velocity: AudioKit.MIDIVelocity, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
    }
    
    func receivedMIDIController(_ controller: AudioKit.MIDIByte, value: AudioKit.MIDIByte, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
    }
    
    func receivedMIDIAftertouch(noteNumber: AudioKit.MIDINoteNumber, pressure: AudioKit.MIDIByte, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
    }
    
    func receivedMIDIAftertouch(_ pressure: AudioKit.MIDIByte, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
    }
    
    func receivedMIDIPitchWheel(_ pitchWheelValue: AudioKit.MIDIWord, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
    }
    
    func receivedMIDIProgramChange(_ program: AudioKit.MIDIByte, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
    }
    
    func receivedMIDISystemCommand(_ data: [AudioKit.MIDIByte], portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
    }
    
    func receivedMIDISetupChange() {
    }
    
    func receivedMIDIPropertyChange(propertyChangeInfo: MIDIObjectPropertyChangeNotification) {
    }
    
    func receivedMIDINotification(notification: MIDINotification) {
    }
}


class AudioAmpSensor : AudioSensor, SensorProtocol {

    override init() {
    }

    func getData() -> Array<Double> {
        return [0.0]
    }
    
    func oscData() -> (String,Array<String>){
        let amp = 0.0//ampTap.amplitude
        print(amp)
        return ("/gyrosc/amp",[String(amp)])
    }
    func midiData() -> String{ return "TODO"}
    
}
