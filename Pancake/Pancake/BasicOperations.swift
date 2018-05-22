//
//  BasicOperations.swift
//  Pancake
//
//  Created by mxa on 16.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

extension Pancake {
    /// This method is called to initialize the instance of thvarlug-in.
    /// As part of initialization, the plug-in should publish all the objects it knows about at the time.
    ///
    /// - Parameters:
    ///   - driver: The plug-in to initialize.
    ///   - host: A host interface that the plug-in should use for communication with the Host. The Host guarantees that the storage will remain valid for the lifetime of the plug-in.
    /// - Returns: The status of the operation.
    func initialize(host: AudioServerPlugInHost?) -> OSStatus {
        // Store the host reference
        self.host = host

        // Do basic setup
        self.setup()

        // Setup signal processor
        self.configuration.pluginSetupCallback?()

        return PancakeAudioHardwareError.noError
    }
}



// MARK: - Transport Manager methods (NOT IMPLEMENTED)
extension Pancake {
    /// (Not supported.)
    ///
    /// Tells the plug-in to create a new AudioEnpointDevice based on the given description.
    ///
    /// - Returns: The status of the operation.
    func createDevice() -> OSStatus {
        return PancakeAudioHardwareError.unsupportedOperation
    }

    /// (Not supported.)
    ///
    /// Called to tell the plug-in about to destroy the given AudioEnpointDevice.
    ///
    /// - Returns: The status of the operation.
    func destroyDevice() -> OSStatus {
        return PancakeAudioHardwareError.unsupportedOperation
    }
}



// MARK: - Client methods (NOT IMPLEMENTED)
extension Pancake {
    /// (Not supported.)
    ///
    /// Called to tell the plug-in about a new client of the Host for a particular device.
    ///
    /// - Returns: The status of the operation.
    func addDeviceClient(deviceID: AudioObjectID, client: AudioServerPlugInClientInfo) -> OSStatus {
        guard let device = self.audioObjects[deviceID] as? PancakeDevice else {
            assertionFailure()
            return PancakeAudioHardwareError.badObject
        }

        let client = HALClient(from: client)
        device.add(client: client)

        return PancakeAudioHardwareError.noError
    }

    /// (Not supported.)
    ///
    /// Called to tell the plug-in about a client that is no longer using the device.
    ///
    /// - Returns: The status of the operation.
    func removeDeviceClient(deviceID: AudioObjectID, client: AudioServerPlugInClientInfo) -> OSStatus {
        guard let device = self.audioObjects[deviceID] as? PancakeDevice else {
            assertionFailure()
            return PancakeAudioHardwareError.badObject
        }

        let client = HALClient(from: client)
        device.remove(client: client)

        return PancakeAudioHardwareError.noError
    }
}



// MARK: - Device configuration changes

extension Pancake {
    /// This is called by the Host to allow the device to perform a configuration change that had been previously requested via a call to the Host method, RequestDeviceConfigurationChange().
    ///
    /// - Parameters:
    ///   - driver The plug-in that owns the device.
    ///   - deviceObjectID The ID of the device that wants to change its configuration.
    ///   - changeAction A UInt64 indicating the action the device object wants to take. This is the same value that was passed to RequestDeviceConfigurationChange(). Note that this value is purely for the plug-in's usage. The Host does not look at this value.
    /// - Returns: The status of the operation.
    func performDeviceConfigurationChange(deviceID: AudioObjectID, action: UInt64) -> OSStatus {
        assertionFailure()
        return PancakeAudioHardwareError.unsupportedOperation

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
        let newSampleRate = Float64(action) // ??
        guard
            let device = self.audioObjects[deviceID] as? PancakeDevice,
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
    func abortDeviceConfigurationChange(deviceID: AudioObjectID, action: UInt64) -> OSStatus {
        assertionFailure()
        return PancakeAudioHardwareError.unsupportedOperation

        //return PancakeAudioHardwareError.noError
    }
}
