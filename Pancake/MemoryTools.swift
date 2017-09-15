//
//  MemoryTools.swift
//  Pancake
//
//  Created by mxa on 09.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio

/// Gets the amout of memory that is occupied by this type when stored in
/// memory. Implementation for non-collection types.
///
/// - Parameter type: A type
/// - Returns: The size of the type.
func sizeof<T>(_ type: T.Type) -> UInt32 {
    return UInt32(MemoryLayout<T>.stride)
}

/// Gets the amout of memory that is occupied by this type when stored in
/// memory. Implementation for collection types.
///
/// - Parameter type: A type
/// - Returns: The size of the type.
func sizeof<T: Collection>(_ type: T.Type) -> UInt32 {
    return UInt32(MemoryLayout<T.Element>.stride)
}


func assure<T>(_ type: T.Type, fitsIn maxOutputSize: UInt32?, error: Error? = nil) throws -> Void {
    // Throw if output size is set and too small
    if let maxOutputSize = maxOutputSize, maxOutputSize < sizeof(type) {
        let error = error ?? PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.badPropertySize)
        throw error
    }
}


func number<T>(of type: T.Type, thatFitIn maxOutputSize: UInt32?) -> Int? {
    // Can't do this operation without an output size
    guard let maxOutputSize = maxOutputSize else { return nil }
    return Int(maxOutputSize / sizeof(type))
}
