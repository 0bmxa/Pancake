//
//  PancakeObject.swift
//  Pancake
//
//  Created by mxa on 29.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

protocol PancakeObjectType {
    init(pancake: Pancake)
    func hasProperty(description: PancakeObjectPropertyDescription) -> Bool
    func getProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty
}

extension PancakeObjectType {
    func hasProperty(description: PancakeObjectPropertyDescription) -> Bool {
        do {
            _ = try self.getProperty(description: description, sizeHint: nil)
        } catch {
            return false
        }
        assertionFailure()
        return true
    }
}

func MakePancakeObject(for audioObjectID: AudioObjectID) throws -> PancakeObjectType {
    guard let objectID = PancakeObjectID(rawValue: audioObjectID) else {
//        assertionFailure("got unknown object ID \(audioObjectID)")
        throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.badObject)
    }
    switch objectID {
    case .plugin,
         .box:
        return PancakePlugin()
        
    case .device,
         .streamInput,
         .streamOutput,
         .volumeInputMaster,
         .volumeOutputMaster,
         .muteInputMaster,
         .muteOutputMaster:
        return PancakeDevice()
        
        
    case .dataSourceInputMaster,
         .dataSourceOutputMaster:
        return PancakeBaseObject()
        
    case .unknown:
        throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.badObject)
    }
}


// =============================================================================
// =============================================================================
// =============================================================================



protocol PancakeError: Error {}

//struct PancakeObjectPropertyQueryError: Error {
struct PancakeObjectPropertyQueryError: PancakeError {
    let status: OSStatus
}

enum PancakeObjectProperty {
    case audioClassID(AudioClassID)
    case string(CFString)
    case pancakeObjectIDList([PancakeObjectID])

    func write(to address: UnsafeMutableRawPointer?, size: UnsafeMutablePointer<UInt32>) {
        switch self {
        case .audioClassID(let data):        self.write(data: data, address: address, size: size)
        case .string(let data):              self.write(data: data, address: address, size: size)
            
        case .pancakeObjectIDList(let data):
            let rawData = data.map { $0.rawValue }
//            address?.assumingMemoryBound(to: [AudioObjectID].self).pointee = rawData
            
            var foo = address?.assumingMemoryBound(to: AudioObjectID.self)
            for element in rawData {
                foo?.pointee = element
                foo = foo?.advanced(by: 1)
            }
            
            size.pointee = UInt32(data.count) * sizeof(AudioObjectID.self)
        }
    }
    
    private func write<T>(data: T, address: UnsafeMutableRawPointer?, size: UnsafeMutablePointer<UInt32>) {
        address?.assumingMemoryBound(to: T.self).pointee = data
        size.pointee = UInt32(MemoryLayout.size(ofValue: data))
    }
}


enum PancakeObjectID: AudioObjectID {
    case unknown                = 0 // = PancakeAudioObjectID.unknown
    case plugin                 = 1 // = PancakeAudioObjectID.plugin
    case box                    = 2
    case device                 = 3
    case streamInput            = 4
    case volumeInputMaster      = 5
    case muteInputMaster        = 6
    case dataSourceInputMaster  = 7
    case streamOutput           = 8
    case volumeOutputMaster     = 9
    case muteOutputMaster       = 10
    case dataSourceOutputMaster = 11
}


