//
//  MachTimebaseInfo.swift
//  Pancake
//
//  Created by mxa on 02.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import Foundation

/// A wrapper around mach_timebase_info.
struct MachTimebaseInfo {
    private let numerator:   UInt32
    private let denominator: UInt32
    
    var ticksPerNanosecond: Double {
        return Double(self.denominator) / Double(self.numerator)
    }
    
    var ticksPerSecond: Double {
        return self.ticksPerNanosecond * Double(kSecondScale)
    }
    
    init() {
        var timebaseInfo = mach_timebase_info()
        let result = mach_timebase_info(&timebaseInfo)
        if result != 0 { assertionFailure() }
        
        self.numerator   = timebaseInfo.numer
        self.denominator = timebaseInfo.denom
    }
}
