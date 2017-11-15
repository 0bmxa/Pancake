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

fileprivate func _AudioObjectGetPropertyData<T>(objectID: AudioObjectID, address: AudioObjectPropertyAddress, dataType: T.Type, elementCount: Int) throws -> [T] {
    // Address pointer
    var mutableAddress = address
    let addressPointer = withUnsafePointer(to: &mutableAddress) { $0 }

    // Allocate some memory to store data
    let propertySize = MemoryLayout<T>.stride * elementCount
    var propertyDataPointer = UnsafeMutablePointer<T>.allocate(capacity: elementCount)

    // Property size
    var mutablePropertySize = UInt32(propertySize)
    let propertySizePointer = withUnsafeMutablePointer(to: &mutablePropertySize) { $0 }

    // Qualifier (unused)
    let qualifierData: UnsafeRawPointer? = nil
    let qualifierDataSize: UInt32 = 0

    // The actual query
    let error = AudioObjectGetPropertyData(objectID, addressPointer, qualifierDataSize, qualifierData, propertySizePointer, propertyDataPointer)
    guard error == noErr else { throw AudioObjectGetPropertyDataError(error: error) }

    // Get property from memory
    let indices = (0 ..< elementCount)
    let properties = indices.map { _ -> T in
        let element = propertyDataPointer.pointee
        propertyDataPointer = propertyDataPointer.advanced(by: 1)
        return element
    }

    return properties
}

func AudioObjectGetPropertyDataSize(objectID: AudioObjectID, address: AudioObjectPropertyAddress) throws -> UInt32 {
    // Address pointer
    var mutableAddress = address
    let addressPointer = withUnsafePointer(to: &mutableAddress) { $0 }

    // Qualifier (unused)
    let qualifierData: UnsafeRawPointer? = nil
    let qualifierDataSize: UInt32 = 0

    var propertyDataSize: UInt32 = 0
    let propertyDataSizePointer = withUnsafeMutablePointer(to: &propertyDataSize) { $0 }

    let error = AudioObjectGetPropertyDataSize(objectID, addressPointer, qualifierDataSize, qualifierData, propertyDataSizePointer)
    guard error == noErr else { throw AudioObjectGetPropertyDataError(error: error) }

    return propertyDataSize
}

struct AudioObjectGetPropertyDataError: Error {
    let error: OSStatus
}
