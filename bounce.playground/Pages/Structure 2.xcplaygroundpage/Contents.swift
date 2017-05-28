//: [Previous](@previous)

import Foundation


protocol Transmitter {
    func transmit(sensor:Sensor)
}

struct OSC : Transmitter {
    func transmit(sensor:Sensor){
        // do OSC stuff to send
        print("OSC -> \(sensor.oscData())")
    }
}


struct MIDI : Transmitter {
    func transmit(sensor:Sensor){
        // do MIDI stuff to send
        print("send MIDI \(sensor.midiData())")
    }
}



protocol Sensor {
    
    func getData() -> Array<Float>
    
    func oscData() -> String
    func midiData() -> String
}

struct Gyro : Sensor {
    
    func getData() -> Array<Float> { return [0.1,0.3] }
    
    func oscData() -> String{ return "/gyro/ \(getData())"}
    func midiData() -> String{ return "cc1:1 \(getData()[0]) cc1:2 \(getData()[1])"}
    
}
struct Accel : Sensor {
    
    func getData() -> Array<Float> { return [Float(arc4random_uniform(100)),0.99] }
    
    func oscData() -> String{ return "/accel/ \(getData())"}
    func midiData() -> String{ return "cc51:1 \(getData()[0]) cc51:2 \(getData()[1])"}
    
}




class SensorTransmitter {
    
    var sensor: Sensor?
    var transmitter: Transmitter?
    weak var timer: Timer?
    
    
    init(s:Sensor,t:Transmitter){
        sensor = s;
        transmitter = t;
    }
    
    func next(){
        transmitter?.transmit(sensor: sensor!)
    }
    func run(interval:Double = 1.0) {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            self?.next()
        }
    }
    
    func stop() {
        timer?.invalidate()
    }
    
    deinit {
        stop()
    }
}


let stA = SensorTransmitter(s: Accel(), t: MIDI())
let stB = SensorTransmitter(s: Gyro(), t: OSC())

stA.run()
stB.run(interval:0.5)

//CFRunLoopRun()

