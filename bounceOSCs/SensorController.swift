//
//  SensorController.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 24/5/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import Foundation



protocol SensorControllerProtocol {
    func onGo() -> Bool
}

class SensorController {
    
    var delegate:SensorControllerProtocol
    
    init(delegate:SensorControllerProtocol){
        self.delegate = delegate;
    }
    
    func doSomething() -> Bool{
        return self.delegate.onGo()
    }
}
