//
//  OSCReciever.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 20/4/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import Foundation
//import OSCKit
import OSCKit

//import Pantry


class OSCReciever : NSObject {
    
//    let server = OSCServer(port: 3333)
    
    override init() {
        super.init()
//        server.delegate = self
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "RX OSC_onOffChanged"), object: nil, queue: nil) { n in
            
//            let value = n.userInfo?["value"] as? Bool
            print("osc rx :")
            
            
//            if(value)!{
//                if let s:String = Pantry.unpack("rxport") {
//                    if let port:Int = Int(s) {
//                        self.server.listen(port)
//                    }
//                }
//            }else{
//                print("[OSCServer] stopped listnening")
//                self.server.stop()
//            }
        }
    }
    
    
    // - OSC Delegate
    func handle(_ message: OSCMessage!) {
        
        print([message.addressPattern,message.values])
//        if(message.address == "/bounce"){
//            
//            if let cmd:String = message.arguments[0] as? String{
//                NotificationCenter.default.post(
//                    name: Notification.Name(rawValue: cmd),
//                    object: nil,
//                    userInfo: nil)
//            }
//        }
        

    }

}
