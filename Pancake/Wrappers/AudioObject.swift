//
//  AudioObject.swift
//  FryingPan
//
//  Created by mxa on 29.09.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import CoreAudio

//swiftlint:disable identifier_name

func AudioObjectGetPropertyData<T: Collection>(objectID: AudioObjectID, address: AudioObjectPropertyAddress, dataType: T.Type) throws -> [T.Element] {
    let dataSize = try AudioObjectGetPropertyDataSize(objectID: objectID, address: address)
    guard dataSize > 0 else { return [] }

    let numberOfElements = Int(dataSize) / MemoryLayout<T.Element>.stride
    return try _AudioObjectGetPropertyData(objectID: objectID, address: address, dataType: T.Element.self, elementCount: numberOfElements)
}

func AudioObjectGetPropertyData<T>(objectID: AudioObjectID, address: AudioObjectPropertyAddress, dataType: T.Type) throws -> T? {
    guard try AudioObjectGetPropertyDataSize(objectID: objectID, address: address) > 0 else { return nil }
    let properties = try _AudioObjectGetPropertyData(objectID: objectID, address: address, dataType: T.self, elementCount: 1)
    return properties[0]
}

private func _AudioObjectGetPropertyData<T>(objectID: AudioObjectID, address: AudioObjectPropertyAddress, dataType: T.Type, elementCount: Int) throws -> [T] {
    // Mutable copy of the address
    var address = address

    // Allocate some memory to store data
    var propertySize = UInt32(MemoryLayout<T>.stride * elementCount)
    let propertyDataPointer = UnsafeMutablePointer<T>.allocate(capacity: elementCount)

    // Qualifier (unused)
    let qualifierData: UnsafeRawPointer? = nil
    let qualifierDataSize: UInt32 = 0

    // The actual query
    let error = AudioObjectGetPropertyData(objectID, &address, qualifierDataSize, qualifierData, &propertySize, propertyDataPointer)
    guard error == noErr else { throw AudioObjectGetPropertyDataError(error: error) }

    // Get property memory as array
    let properties = Array(UnsafeBufferPointer(start: propertyDataPointer, count: elementCount))

    // Free memory
    propertyDataPointer.deallocate(capacity: elementCount)

    return properties
}

func AudioObjectGetPropertyDataSize(objectID: AudioObjectID, address: AudioObjectPropertyAddress) throws -> UInt32 {
    // Mutable copy of the address
    var address = address

    // Qualifier (unused)
    let qualifierData: UnsafeRawPointer? = nil
    let qualifierDataSize: UInt32 = 0

    var propertyDataSize: UInt32 = 0

    let error = AudioObjectGetPropertyDataSize(objectID, &address, qualifierDataSize, qualifierData, &propertyDataSize)
    guard error == noErr else { throw AudioObjectGetPropertyDataError(error: error) }

    return propertyDataSize
}

struct AudioObjectGetPropertyDataError: Error {
    let error: OSStatus
}
