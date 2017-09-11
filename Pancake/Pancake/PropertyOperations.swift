//
//  PropertyOperations.swift
//  Pancake
//
//  Created by mxa on 02.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

class PropertyAddress {
    let pointer: UnsafePointer<AudioObjectPropertyAddress>
    
    init?(from pointer: UnsafePointer<AudioObjectPropertyAddress>?) {
        guard let pointer = pointer else { return nil }
        self.pointer = pointer
    }
    
    var element: AudioObjectPropertyElement {
        return self.pointer.pointee.mElement
    }
    
    var scope: AudioObjectPropertyScope {
        return self.pointer.pointee.mScope
    }
    
    var selector: PancakeAudioObjectPropertySelector? {
        return PancakeAudioObjectPropertySelector(from: self.pointer.pointee.mSelector)
    }
}

// MARK: - Property Operations
extension Pancake {
    func hasProperty(driver: AudioServerPlugInDriver?, objectID: AudioObjectID, propertyAddress: PropertyAddress?) -> Bool {
        guard valid(driver) else { return false }
        guard
            let selector = propertyAddress?.selector,
            let pancakeObject = try? MakePancakeObject(for: objectID)
        else {
            assertionFailure()
            return false
        }
        
        return pancakeObject.hasProperty(selector: selector)
    }
    
    func isPropertySettable(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, outIsSettable: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus {
        fatalError(); //return 0
    }
    
    func getPropertyData(driver: AudioServerPlugInDriver?, objectID: AudioObjectID, propertyAddress: UnsafePointer<AudioObjectPropertyAddress>?, dataSize: UInt32?, outData: UnsafeMutableRawPointer?, outDataSize: UnsafeMutablePointer<UInt32>?) -> OSStatus {
        guard valid(driver) else { return PancakeAudioHardwareError.badObject }
        
        guard
            let propertyAddress = propertyAddress?.pointee,
            let outDataSize = outDataSize
        else {
            assertionFailure()
            return PancakeAudioHardwareError.badObject
        }

        
        // Get property
        let property: PancakeObjectProperty
        do {
            let pancakeObject = try MakePancakeObject(for: objectID)
            property = try pancakeObject.getProperty(address: propertyAddress, sizeHint: dataSize)
        } catch {
            return (error as! PancakeObjectPropertyQueryError).status
        }
        
        // Write property size (and data if memory available)
        property.write(to: outData, size: outDataSize)
        return PancakeAudioHardwareError.noError
    }
    

    
    func setPropertyData(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, inDataSize: UInt32, inData: UnsafeRawPointer) -> OSStatus {
        fatalError(); //return 0
    }
}


enum Response<T> {
    case success(data: T)
    case failure(status: OSStatus)
}


func valid(_ driver: AudioServerPlugInDriver?) -> Bool {
    let isValid = (driver != nil && driver == Pancake.shared.driver)
    if !isValid { assertionFailure() }
    return isValid
}
