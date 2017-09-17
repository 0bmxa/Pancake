//
//  PancakeObjectProperty.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio

enum PancakeObjectProperty {
    case audioClassID(AudioClassID)
    case string(CFString)
    case integer(UInt32)
    case pancakeObjectIDList([AudioObjectID])
    case customPropertyInfoList([AudioServerPlugInCustomPropertyInfo])
    case streamDescriptionList([AudioStreamRangedDescription])

    func write(to address: UnsafeMutableRawPointer?, size: UnsafeMutablePointer<UInt32>) {
        switch self {
        case .audioClassID(let data):           self.write(element: data, address: address, size: size)
        case .string(let data):                 self.write(element: data, address: address, size: size)
        case .integer(let data):                self.write(element: data, address: address, size: size)
            
        case .pancakeObjectIDList(let data):    self.writeArray(array: data, address: address, size: size)
        case .customPropertyInfoList(let data): self.writeArray(array: data, address: address, size: size)
        case .streamDescriptionList(let data):  self.writeArray(array: data, address: address, size: size)
        }
    }
    
    private func write<T>(element: T, address: UnsafeMutableRawPointer?, size: UnsafeMutablePointer<UInt32>) {
        // Write data size
        address?.assumingMemoryBound(to: T.self).pointee = element
        
        // Write data
        size.pointee = UInt32(MemoryLayout.size(ofValue: element))
    }
    
    private func writeArray<T: Collection>(array: T, address: UnsafeMutableRawPointer?, size: UnsafeMutablePointer<UInt32>) {
        // Write data size
        size.pointee = UInt32(array.count) * sizeof(T.Element.self)
        
        // Write data
        guard let address = address else { return }
        var currentAddress = address.assumingMemoryBound(to: T.Element.self)
        for element in array {
            currentAddress.pointee = element
            currentAddress = currentAddress.advanced(by: 1)
        }
    }
}
