//
//  CoreFoundation.swift
//  Pancake
//
//  Created by mxa on 04.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreFoundation

/// Wrapper around CFByteOrder
enum ByteOrder {
    case bigEndian
    case littleEndian
    case unknown
    
    static var current: ByteOrder {
        switch CFByteOrderGetCurrent() {
        case Int(CFByteOrderBigEndian.rawValue):    return .bigEndian
        case Int(CFByteOrderLittleEndian.rawValue): return .littleEndian
        default:                                    return .unknown
        }
    }
}
