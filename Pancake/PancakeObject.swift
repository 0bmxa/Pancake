//
//  PancakeObject.swift
//  Pancake
//
//  Created by mxa on 29.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

protocol PancakeObject {
    init(with objectID: PancakeObjectID, pancake: Pancake)
    func hasProperty(selector: PancakeAudioObjectPropertySelector) -> Bool
    func getProperty(address: AudioObjectPropertyAddress, sizeHint: UInt32?) throws -> PancakeObjectProperty
}

func MakePancakeObject(for audioObjectID: AudioObjectID) throws -> PancakeObject {
    guard let objectID = PancakeObjectID(rawValue: audioObjectID) else {
//        assertionFailure("got unknown object ID \(audioObjectID)")
        throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.badPropertySize)
    }
    return PancakeObjectoooor(with: objectID)
}

class PancakeObjectoooor: PancakeObject {
    private let objectID: PancakeObjectID?
    private let pancake: Pancake
    
    required init(with objectID: PancakeObjectID, pancake: Pancake = Pancake.shared) {
        self.objectID = objectID
        self.pancake = pancake
    }

    
    func hasProperty(selector: PancakeAudioObjectPropertySelector) -> Bool {
        switch selector {
        case .objectBaseClass,
             .objectClass,
             .pluginBoxList:
            return true
        case .objectCustomPropertyInfoList,
             .pluginClockDeviceList:
            return false
        default:
            assertionFailure()
            return false
        }
    }

    
    func getProperty(address: AudioObjectPropertyAddress, sizeHint: UInt32?) throws -> PancakeObjectProperty {
        guard let selector = PancakeAudioObjectPropertySelector(from: address.mSelector) else {
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }

        print("### getProperty:", selector)
        
        switch selector {
        case .objectBaseClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioObject.classID)
            
        case .objectClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioPlugin.classID)
            
        case .objectOwner:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioObjectID.unknown)
            
        case .objectManufacturer:
            try assure(CFString.self, fitsIn: sizeHint)
            return .string(pancake.configuration.manufacturer as CFString)
            
        case .objectOwnedObjects:
            fatalError()
//            try assure(<#AudioClassID#>.self, fitsIn: sizeHint)
//            return .<#audioClassID#>(<#AudioObject.classID#>)

            
            
        case .pluginBoxList:
            let expectedNumberOfElements = try numberOfElements(of: AudioObjectID.self, thatFitIn: sizeHint)
            guard expectedNumberOfElements > 0 else {
                return .pancakeObjectIDList([])
            }
            
            // We only have one box, so always return this one
            let boxID = PancakeObjectID.box
            return .pancakeObjectIDList([boxID])
            

        case .pluginTranslateUIDToBox:
            fatalError()
//            try assure(<#AudioClassID#>.self, fitsIn: sizeHint)
//            return .<#audioClassID#>(<#AudioObject.classID#>)

        case .pluginDeviceList:
            let expectedNumberOfElements = try numberOfElements(of: AudioObjectID.self, thatFitIn: sizeHint)
            guard expectedNumberOfElements > 0 else {
                return .pancakeObjectIDList([])
            }
            
            // Get devices
            let availableDevices = pancake.plugin.devices
            let numberOfElementsToReturn = min(expectedNumberOfElements, availableDevices.count)
            let devices = Array(availableDevices[ 0..<numberOfElementsToReturn ])
            return .pancakeObjectIDList(devices)

        case .pluginTranslateUIDToDevice:
            fatalError()
//            if let size = sizeHint, size < sizeof(<#AudioClassID#>.self) { throw badPropertySizeError }
//            return PancakeObjectProperty(data: <#data#>)

//        case .pluginResourceBundle:
//            fatalError()
//            if let size = sizeHint, size < sizeof(<#AudioClassID#>.self) { throw badPropertySizeError }
//            return PancakeObjectProperty(data: <#data#>)
            
        case .objectName, .objectModelName, .objectElementName:
             fatalError()
            
        // TODO: make this `default`
        case .deviceUID:
            try assure(CFString.self, fitsIn: sizeHint)
            return .string("Pancake Device" as CFString)

        case .boxUID:
            try assure(CFString.self, fitsIn: sizeHint)
            return .string("Pancake Box" as CFString)

        default:
            print(selector)
            fatalError()
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
}

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
            address?.assumingMemoryBound(to: [AudioObjectID].self).pointee = rawData
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


