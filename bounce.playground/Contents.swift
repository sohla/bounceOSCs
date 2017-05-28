//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


protocol base {
    var data:Float {get}
    
}
struct someA : base{
    let data:Float = 0.1
}

struct someB : base{
    let data:Float = 0.2
}

struct builder {
    let a:someA
    let b:someB
    
    func doit() -> Float {
        return a.data + b.data
    }
}

let sa = someA.init()
let sb = someB.init()

let b = builder.init(a: sa, b: sb).doit()

/******/
/*

    Gyro
        OSC     gyro/attitude/pry [1.1,2.2,3.3]
        MIDI    [cc11,vl1.1],[cc12,vl2.2]....
 

*/
/******/


/*
protocol Transmitter {
    func send(msg:String)
}

struct OSC : Transmitter {
    func send(msg:String){
        print("send OSC ->\(msg)")
    }
}


struct MIDI : Transmitter {
    func send(msg:String){
        print("send MIDI ->\(msg)")
    }
}



protocol Sensor {
    
    func getData() -> Float
    
    func transmit(t:Transmitter)
}

struct Gyro : Sensor {
    
    func getData() -> Float { return 0.2 }
    
    func transmit(t: Transmitter) {
        t.send(msg:"/gyro/data/\(getData())")
    }
}
struct Accel : Sensor {
    func getData() -> Float { return Float(arc4random_uniform(100)) }
    func transmit(t: Transmitter) {
        t.send(msg:"/accel/data/\(getData())")
    }
}



class SnsrTx {
    var sensor: Sensor?
    var transmitter: Transmitter?
    weak var timer: Timer?
    
    
    init(s:Sensor,t:Transmitter){
        sensor = s;
        transmitter = t;
    }
    
    func next(){
        //transmitter?.transmit(sensor: sensor!)
        
        sensor?.transmit(t: transmitter!)
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

let stA = SnsrTx(s: Accel(), t: MIDI())
let stB = SnsrTx(s: Gyro(), t: OSC())

stA.run()
stB.run(interval:0.5)

//CFRunLoopRun()
*/
/******/


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


class SnsrTx {
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


let stA = SnsrTx(s: Accel(), t: MIDI())
let stB = SnsrTx(s: Gyro(), t: OSC())

stA.run()
stB.run(interval:0.5)

//CFRunLoopRun()
 