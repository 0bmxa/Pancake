//
//  IOOperations.swift
//  Pancake
//
//  Created by mxa on 05.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

// swiftlint:disable function_parameter_count force_cast

// MARK: - IO Operations
extension Pancake {

    // FIXME:
    static var seenClients: [(clientID: UInt32, action: String)] = []

    func startIO(objectID: AudioObjectID, clientID: UInt32) -> OSStatus {
        Pancake.seenClients.append((clientID: clientID, action: "startIO"))
        guard let device = self.audioObjects[objectID] as? PancakeDevice else {
            assertionFailure()
            return PancakeAudioHardwareError.badObject
        }

        do {
            try device.startIO()
        } catch {
            return (error as! PancakeObjectPropertyQueryError).status
        }

        return PancakeAudioHardwareError.noError
    }


    func stopIO(objectID: AudioObjectID, clientID: UInt32) -> OSStatus {
        Pancake.seenClients.append((clientID: clientID, action: "stopIO"))

        guard let device = self.audioObjects[objectID] as? PancakeDevice else {
            assertionFailure()
            return PancakeAudioHardwareError.badObject
        }

        do {
            try device.stopIO()
        } catch {
            return (error as! PancakeObjectPropertyQueryError).status
        }

        return PancakeAudioHardwareError.noError
    }


    func getZeroTimeStamp(objectID: AudioObjectID, clientID: UInt32, outSampleTime: UnsafeMutablePointer<Float64>, outHostTime: UnsafeMutablePointer<UInt64>, outSeed: UnsafeMutablePointer<UInt64>) -> OSStatus {
        Pancake.seenClients.append((clientID: clientID, action: "getZeroTimeStamp"))

        guard let device = self.audioObjects[objectID] as? PancakeDevice else {
            assertionFailure()
            return PancakeAudioHardwareError.badObject
        }

        /// Get timestamps from device
        let zeroTimeStamps = device.zeroTimeStamp()

        // Write data to memory
        outSampleTime.pointee = zeroTimeStamps.sampleTime
        outHostTime.pointee   = zeroTimeStamps.hostTime
        outSeed.pointee       = zeroTimeStamps.timelineSeed

        return PancakeAudioHardwareError.noError
    }


    func willDoIOOperation(objectID: AudioObjectID, clientID: UInt32, operation: AudioServerPlugInIOOperation?, outWillDo: UnsafeMutablePointer<DarwinBoolean>, outWillDoInPlace: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus {
        Pancake.seenClients.append((clientID: clientID, action: "willDoIOOperation"))

        guard
            let operation = operation,
            let device = self.audioObjects[objectID] as? PancakeDevice
            else {
                assertionFailure()
                return PancakeAudioHardwareError.badObject
        }

        // Get operation support from device
        let support = device.supports(operation: operation)

        // Write data to memory
        outWillDo.pointee        = DarwinBoolean(support.supported)
        outWillDoInPlace.pointee = DarwinBoolean(support.isInPlaceOperation)

        return 0
    }


    func beginIOOperation(objectID: AudioObjectID, clientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus {
        Pancake.seenClients.append((clientID: clientID, action: "beginIOOperation"))
        // nothing to do here for now
        return PancakeAudioHardwareError.noError
    }


    func doIOOperation(deviceObjectID: AudioObjectID, clientID: UInt32, streamObjectID: AudioObjectID, operation: AudioServerPlugInIOOperation?, IOBufferFrameSize: UInt32, IOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>, mainBuffer: UnsafeMutableRawPointer?, secondaryBuffer: UnsafeMutableRawPointer?) -> OSStatus {
        Pancake.seenClients.append((clientID: clientID, action: "doIOOperation"))

        guard let device = self.audioObjects[deviceObjectID] as? PancakeDevice else {
            return PancakeAudioHardwareError.badObject
        }
        guard let operation = operation else {
            return PancakeAudioHardwareError.illegalOperation
        }
        guard let mainBuffer = mainBuffer else {
            if operation == .readInput {
                return PancakeAudioHardwareError.badObject
            }
            if operation == .writeMix {
                return PancakeAudioHardwareError.badObject
            }

            return PancakeAudioHardwareError.badObject
        }

        // Execute IO operation on device
        do {
            try device.execute(operation: operation, streamObjectID: streamObjectID, numberOfFrames: Int(IOBufferFrameSize), cycle: IOCycleInfo.pointee, buffer: mainBuffer)
        } catch {
            return (error as! PancakeObjectPropertyQueryError).status
        }

        return PancakeAudioHardwareError.noError
    }


    func endIOOperation(objectID: AudioObjectID, clientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus {
        Pancake.seenClients.append((clientID: clientID, action: "endIOOperation"))
        // nothing to do here for now
        return PancakeAudioHardwareError.noError
    }
}
