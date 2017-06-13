import Foundation


//enum SensorTypes : Int {
//    
//    enum Motion {
//        case Accel
//        case Gyro
//        case Gravity
//    }
//    
//    enum Audio {
//        case Amp
//        case Pitch
//    }
//    
//    case Test
//}

//protocol CaseCountable: RawRepresentable {}
//extension CaseCountable where RawValue == Int {
//    static var count: RawValue {
//        var i: RawValue = 0
//        while let _ = Self(rawValue: i) { i += 1 }
//        return i
//    }
//}
//enum SensorTypes : Int , CaseCountable{
//    case Motion
//    case Audio
//}
//
//
//enum MotionTypes : Int , CaseCountable{
//    case Accel
//    case Gyro
//    case Gravity
//    
//}
//SensorTypes.count
//MotionTypes.count
//
//SensorTypes.Motion.rawValue
//
//SensorTypes.Motion.Accel
//print("\(SensorTypes.Motion.Accel)")
//
let types: Dictionary<String,Any> = ["Motion":["Accel","Gyro"]]

let a:Array<String> = ["A","B"]

print(a)

let b = [1,2,3,4].map { $0 * 2 }
b
//(types.first?.value as! Array)




