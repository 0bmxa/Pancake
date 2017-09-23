//
//  PancakeObjectProperty.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio

enum PancakeObjectProperty {
    // Primitives
    case audioClassID(AudioClassID)
    case string(CFString)
    case integer(UInt32)
    case float32(Float32)
    case float64(Float64)
    case url(CFURL)
    case scope(AudioObjectPropertyScope)
    case element(AudioObjectPropertyElement)
    
    // Structs
    case streamDescription(AudioStreamBasicDescription)
    case channelLayout(AudioChannelLayout)

    // Arrays
    case pancakeObjectIDList([AudioObjectID])
    case customPropertyInfoList([AudioServerPlugInCustomPropertyInfo])
    case streamDescriptionList([AudioStreamRangedDescription])
    case valueRangeList([AudioValueRange])
    case integerList([UInt32])

    /// Writes the property and the property's size to memory
    ///
    /// - Parameters:
    ///   - address: A pointer to the address for the property data to be written to.
    ///   - size: A pointer to the address for the property size to be written to.
    func write(to address: UnsafeMutableRawPointer?, size: UnsafeMutablePointer<UInt32>) {
        switch self {
        case .string(let data):                 self.write(element: data, address: address, size: size)
        case .float32(let data):                self.write(element: data, address: address, size: size)
        case .float64(let data):                self.write(element: data, address: address, size: size)
        case .url(let data):                    self.write(element: data, address: address, size: size)
        case .integer(let data),
             .scope(let data),
             .element(let data),
             .audioClassID(let data):           self.write(element: data, address: address, size: size)

        case .streamDescription(let data):      self.write(element: data, address: address, size: size)
        case .channelLayout(let data):          self.write(element: data, address: address, size: size)

        case .pancakeObjectIDList(let data):    self.write(array: data, address: address, size: size)
        case .customPropertyInfoList(let data): self.write(array: data, address: address, size: size)
        case .streamDescriptionList(let data):  self.write(array: data, address: address, size: size)
        case .valueRangeList(let data):         self.write(array: data, address: address, size: size)
        case .integerList(let data):            self.write(array: data, address: address, size: size)
        }
    }


    // TODO: Test it this works for structs
    private func write<T>(element: T, address: UnsafeMutableRawPointer?, size: UnsafeMutablePointer<UInt32>) {
        // Write data size
        size.pointee = UInt32(MemoryLayout.size(ofValue: element))

        // Write data
        address?.assumingMemoryBound(to: T.self).pointee = element

        printcake("Wrote \(self)", (address == nil ? "(size only)" : ""))
    }

    private func write<T: Collection>(array: T, address: UnsafeMutableRawPointer?, size: UnsafeMutablePointer<UInt32>) {
        // Write data size
        size.pointee = UInt32(array.count) * sizeof(T.Element.self)

        // Write data
        guard let address = address else {
            //printcake("Wrote", array.count, "Elements of", self, "(size only)")
            return
        }
        var currentAddress = address.assumingMemoryBound(to: T.Element.self)
        for element in array {
            currentAddress.pointee = element
            currentAddress = currentAddress.advanced(by: 1)
        }

        printcake("Wrote", array.count, "elements of \(self)")
    }
}
