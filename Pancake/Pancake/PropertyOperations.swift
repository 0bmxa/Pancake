//
//  PropertyOperations.swift
//  Pancake
//
//  Created by mxa on 02.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

// swiftlint:disable force_cast

// MARK: - Property Operations
extension Pancake {
    func hasProperty(objectID: AudioObjectID, description: PancakeObjectPropertyDescription?) -> Bool {
        guard
            let pancakeObject = self.audioObjects[objectID],
            let description = description
        else {
            //assertionFailure()
            return false
        }

        return pancakeObject.hasProperty(description: description)
    }

    func isPropertySettable(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, outIsSettable: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus {
        fatalError(); //return 0
    }

    func getPropertyData(objectID: AudioObjectID, description: PancakeObjectPropertyDescription?, dataSize: UInt32?, outData: UnsafeMutableRawPointer?, outDataSize: UnsafeMutablePointer<UInt32>?) -> OSStatus {
        guard
            let description = description,
            let outDataSize = outDataSize,
            let pancakeObject = self.audioObjects[objectID]
        else {
            assertionFailure()
            return PancakeAudioHardwareError.badObject
        }


        // Get property
        let property: PancakeObjectProperty
        do {
            property = try pancakeObject.getProperty(description: description, sizeHint: dataSize)
        } catch {
            return (error as! PancakeObjectPropertyQueryError).status
        }

        // Write property size (and data if memory available)
        property.write(to: outData, size: outDataSize)
        return PancakeAudioHardwareError.noError
    }



    func setPropertyData(objectID: AudioObjectID, description: PancakeObjectPropertyDescription?, dataSize: UInt32, data: UnsafeRawPointer) -> OSStatus {
        guard
            let description = description,
            let pancakeObject = self.audioObjects[objectID]
            else {
                assertionFailure()
                return PancakeAudioHardwareError.badObject
        }

        // Set property
        do {
            try pancakeObject.setProperty(description: description, data: data)
        } catch {
            return (error as! PancakeObjectPropertyQueryError).status
        }

        return PancakeAudioHardwareError.noError
    }
}
