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

    func startIO(objectID: AudioObjectID, clientID: UInt32) -> OSStatus {
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
        // nothing to do here for now
        return PancakeAudioHardwareError.noError
    }


    /// Tells the device to perform an IO operation for a particular stream.
    ///
    /// - Parameters:
    ///   - deviceObjectID: The ID of the device.
    ///   - clientID: The ID of the client doing the operation. This will have
    ///       been established with the device by a previous call to
    ///       AddDeviceClient().
    ///   - streamObjectID: The ID of the stream whose data is being processed.
    ///   - operation: A UInt32 that identifies the operation being performed.
    ///       Constants for the valid values of this argument are listed in the
    ///       Constants section.
    ///   - IOBufferFrameSize: The number of sample frames that will be
    ///       processed in this operation. Note that for some operations, this
    ///       will be different than the nominal buffer frame size.
    ///   - IOCycleInfo: The basic information about the current IO cycle.
    ///   - mainBuffer: The primary buffer for the data for the operation. If
    ///       the device signaled through WillDoIOOperation() that the operation
    ///       will be handled in-place, this will be the only buffer passed in.
    ///   - secondaryBuffer: The secondary buffer for performing the operation.
    ///       If the device signaled through WillDoIOOperation() that the
    ///       operation will not be handled in place, the results of the
    ///       operation must end up in this buffer.
    /// - Returns: An OSStatus indicating success or failure.
    func doIOOperation(deviceID: AudioDeviceID, clientID: UInt32, streamID: AudioStreamID, operation: AudioServerPlugInIOOperation?, IOBufferFrameSize: UInt32, IOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>, mainBuffer: UnsafeMutableRawPointer?, secondaryBuffer: UnsafeMutableRawPointer?) -> OSStatus {
        guard let device = self.audioObjects[deviceID] as? PancakeDevice else {
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
            try device.execute(operation: operation, streamObjectID: streamID, numberOfFrames: Int(IOBufferFrameSize), cycle: IOCycleInfo.pointee, buffer: mainBuffer)
        } catch {
            return (error as! PancakeObjectPropertyQueryError).status
        }

        return PancakeAudioHardwareError.noError
    }


    /// Tells the plug-in that the Host is about to end a phase of the IO cycle
    /// for a particular device.
    ///
    /// - Parameters:
    ///   - deviceObjectID: The ID of the device.
    ///   - clientID: The ID of the client doing the operation. This will have
    ///       been established with the device by a previous call to
    ///       AddDeviceClient().
    ///   - operationID: A UInt32 that identifies the operation being performed.
    ///       Constants for the valid values of this argument are listed in the
    ///       Constants section.
    ///   - IOBufferFrameSize: The number of sample frames that will be
    ///       processed in this operation. Note that for some operations, this
    ///       will be different than the nominal buffer frame size.
    ///   - IOCycleInfo: The basic information about the current IO cycle.
    /// - Returns: An OSStatus indicating success or failure.
    func endIOOperation(objectID: AudioObjectID, clientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus {
        // nothing to do here for now
        return PancakeAudioHardwareError.noError
    }
}
