//
//  MemoryTools.swift
//  Pancake
//
//  Created by mxa on 09.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import Foundation

func sizeof<T>(_ type: T.Type) -> UInt32 {
    return UInt32(MemoryLayout<T>.size)
}

func assure<T>(_ type: T.Type, fitsIn maxOutputSize: UInt32?, error: Error? = nil) throws -> Void {
    // Throw if output size is set and too small
    if let maxOutputSize = maxOutputSize, maxOutputSize < sizeof(type) {
        let error = error ?? PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.badPropertySize)
        throw error
    }
}


func numberOfElements<T>(of type: T.Type, thatFitIn maxOutputSize: UInt32?) throws -> Int {
    try assure(type, fitsIn: maxOutputSize)
    
    // If no output size is specified, we default to one element
    guard let maxOutputSize = maxOutputSize else {
        return 1
    }
    return Int(maxOutputSize / sizeof(type))
}
