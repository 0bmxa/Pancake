//
//  BasicOperations.swift
//  Pancake
//
//  Created by mxa on 16.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import Foundation
import CoreAudio.AudioServerPlugIn


extension Pancake {
    /// This method is called to initialize the instance of thvarlug-in.
    /// As part of initialization, the plug-in svarld publish all the objects it knows about at the time.
    ///
    /// - Pvarmeters:
    ///   - driver: The plug-in to initialize.
    ///   - host: A host interface that the plug-in should use for communication with the Host. The Host guarantees that the storage will remain valid for the lifetime of the plug-in.
    /// - Returns: The status of the operation.
    func initialize(driver: AudioServerPlugInDriver?, host: AudioServerPlugInHost?) -> OSStatus {
        guard valid(driver) else { return PancakeAudioHardwareError.badObject }

        // Store the host reference
        self.host = host

        // Do basic setup
        self.setup()

        return PancakeAudioHardwareError.noError
    }
}



// MARK: - Transport Manager methods (NOT IMPLEMENTED)
extension Pancake {
    /// (Not supported.)
    /// Tells the plug-in to create a new device based on the given description.
    ///
    /// - Returns: The status of the operation.
    func createDevice() -> OSStatus {
        return PancakeAudioHardwareError.unsupportedOperation
    }

    /// (Not supported.)
    /// Called to tell the plug-in about to destroy the given device.
    ///
    /// - Returns: The status of the operation.
    func destroyDevice() -> OSStatus {
        return PancakeAudioHardwareError.unsupportedOperation
    }

    /// (Not supported.)
    /// Called to tell the plug-in about a new client of the Host for a particular device.
    ///
    /// - Returns: The status of the operation.
    func addDeviceClient() -> OSStatus {
        return PancakeAudioHardwareError.noError
    }

    /// (Not supported.)
    /// Called to tell the plug-in about a client that is no longer using the device.
    ///
    /// - Returns: The status of the operation.
    func removeDeviceClient() -> OSStatus {
        return PancakeAudioHardwareError.noError
    }
}



// MARK: - <#Description#>
extension Pancake {
    /// This is called by the Host to allow the device to perform a configuration change that had been previously requested via a call to the Host method, RequestDeviceConfigurationChange().
    ///
    /// - Parameters:
    ///   - driver The plug-in that owns the device.
    ///   - deviceObjectID The ID of the device that wants to change its configuration.
    ///   - changeAction A UInt64 indicating the action the device object wants to take. This is the same value that was passed to RequestDeviceConfigurationChange(). Note that this value is purely for the plug-in's usage. The Host does not look at this value.
    /// - Returns: The status of the operation.
    func performDeviceConfigurationChange(driver: AudioServerPlugInDriver?, deviceObjectID: AudioObjectID, changeAction: UInt64) -> OSStatus {
        guard valid(driver) else { return PancakeAudioHardwareError.badObject }

        //    This method is called to tell the device that it can perform the configuation change that it
        //    had requested via a call to the host method, RequestDeviceConfigurationChange(). The
        //    arguments, inChangeAction and inChangeInfo are the same as what was passed to
        //    RequestDeviceConfigurationChange().
        //
        //    The HAL guarantees that IO will be stopped while this method is in progress. The HAL will
        //    also handle figuring out exactly what changed for the non-control related properties. This
        //    means that the only notifications that would need to be sent here would be for either
        //    custom properties the HAL doesn't know about or for controls.
        //
        //    For the device implemented by this driver, only sample rate changes go through this process
        //    as it is the only state that can be changed for the device that isn't a control. For this
        //    change, the new sample rate is passed in the inChangeAction argument.

        // ---
        let newSampleRate = Float64(changeAction) // ??
        guard
            let device = self.audioObjects[deviceObjectID] as? PancakeDevice,
            let newFormat = device.configuration.supportedFormats.first(where: { $0.mSampleRate == newSampleRate })
        else {
            assertionFailure()
            return PancakeAudioHardwareError.badObject
        }
        device.configuration.registeredFormat = newFormat
        // ---

        fatalError()
        //return PancakeAudioHardwareError.noError
    }



    /// This is called by the Host to tell the plug-in not to perform a configuration change that had been requested via a call to the Host method, RequestDeviceConfigurationChange().
    ///
    /// - Parameters:
    ///   - driver The plug-in that owns the device.
    ///   - deviceObjectID The ID of the device that wants to change its configuration.
    ///   - changeAction A UInt64 indicating the action the device object wants to take. This is the same value that was passed to RequestDeviceConfigurationChange(). Note that this value is purely for the plug-in's usage. The Host does not look at this value.
    /// - Returns: The status of the operation.
    func abortDeviceConfigurationChange(driver: AudioServerPlugInDriver?, inDeviceObjectID: AudioObjectID, inChangeAction: UInt64) -> OSStatus {
        fatalError(); //return 0
    }
}
