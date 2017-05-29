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

/******/
let floatArray = [12, 14.6, 35]
let stringArray = floatArray.flatMap { String($0) }
stringArray
let string = stringArray.joined(separator: ",")
let arrayString = [string]

func tuple() -> (Int,Int){
    
    return (1,2)
}

tuple().0


