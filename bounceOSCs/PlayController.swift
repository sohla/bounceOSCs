//
//  PlayController.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 29/5/2024.
//  Copyright © 2024 Stephen OHara. All rights reserved.
//

import UIKit
import AudioKit
import CoreMIDI
import Haptica
import SoundpipeAudioKit

class PlayController: UIViewController, MIDIListener {
    
    let engine = AudioEngine()
    let midi = MIDI.sharedInstance
    var osc = DynamicOscillator()
    var env: AmplitudeEnvelope
    
    
    required init?(coder aDecoder: NSCoder) {
        self.env = AmplitudeEnvelope(osc)
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(midi.inputNames)
        midi.addListener(self)
        
        
        engine.output = env
        try? engine.start()
        osc.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        midi.openInput()
        
        print("start playing....")

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        midi.closeInput()
        print("stop playing")
    }
    
    
    // MIDI DELEGATE
    
    func receivedMIDINoteOn(noteNumber: AudioKit.MIDINoteNumber, velocity: AudioKit.MIDIVelocity, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
        print("midi note on: \(noteNumber) velocity: \(velocity) channel: \(channel)")
        
        osc.frequency = AUValue(noteNumber).midiNoteToFrequency()
        env.openGate()
        DispatchQueue.main.async(execute: {
            Haptic.impact(.heavy).generate()
            
            self.view.backgroundColor = UIColor(hue: CGFloat(noteNumber) / 128.0, saturation: 0.8, brightness: 1.0, alpha: 1.0)
            UIView.animate(withDuration: 0.3, animations: {
                self.view.backgroundColor = UIColor.black
            })
        })
    }
    

    
    func receivedMIDINoteOff(noteNumber: AudioKit.MIDINoteNumber, velocity: AudioKit.MIDIVelocity, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {

        DispatchQueue.main.async(execute: {
            self.env.closeGate()
        })

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
