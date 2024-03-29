//: [Previous](@previous)

import Foundation


protocol TransmitterProtocol {
    func transmit(sensor:SensorProtocol)
}

struct OSC : TransmitterProtocol {
    func transmit(sensor:SensorProtocol){
        // do OSC stuff to send
        print("OSC -> \(sensor.oscData())")
    }
}


struct MIDI : TransmitterProtocol {
    func transmit(sensor:SensorProtocol){
        // do MIDI stuff to send
        print("send MIDI \(sensor.midiData())")
    }
}



protocol SensorProtocol {
    
    func getData() -> Array<Float>
    
    func oscData() -> String
    func midiData() -> String
}

struct Gyro : SensorProtocol {
    
    func getData() -> Array<Float> { return [0.1,0.3] }
    
    func oscData() -> String{ return "/gyro/ \(getData())"}
    func midiData() -> String{ return "cc1:1 \(getData()[0]) cc1:2 \(getData()[1])"}
    
}
struct Accel : SensorProtocol {
    
    func getData() -> Array<Float> { return [Float(arc4random_uniform(100)),0.99] }
    
    func oscData() -> String{ return "/accel/ \(getData())"}
    func midiData() -> String{ return "cc51:1 \(getData()[0]) cc51:2 \(getData()[1])"}
    
}

struct Seconds : SensorProtocol {
    
    let today:Date = Calendar.current.startOfDay(for:Date())
    
    func getData() -> Array<Float>{
        
        let d:Double = Date().timeIntervalSince(today)
        
        return [Float(d)]
    }
    
    func oscData() -> String{
        return "Todays Time -> \(getData()[0]) secs"
    }
    func midiData() -> String{
        return "MIDITime ->\(getData()[0])"
    }
    
}


class SensorTransmitter {
    
    var sensor: SensorProtocol?
    var transmitter: TransmitterProtocol?
    weak var timer: Timer?
    
    
    init(sensor:SensorProtocol,transmitter:TransmitterProtocol){
        self.sensor = sensor;
        self.transmitter = transmitter;
    }
    
    @objc func next(){
        transmitter?.transmit(sensor: sensor!)
    }
    func run(interval:Double = 1.0) {
//        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
//            self?.next()
//        }

        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(next), userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer?.invalidate()
    }
    
    deinit {
        stop()
    }
}


let stA = SensorTransmitter(sensor: Accel(), transmitter: MIDI())
let stB = SensorTransmitter(sensor: Seconds(), transmitter: OSC())

//stA.run()
stB.run(interval:0.5)

//CFRunLoopRun()



