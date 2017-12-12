//
//  DriverInterface.swift
//  Pancake
//
//  Created by mxa on 20.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn


/* =========================================================================== *
 *                                                                             *
 *   This file contains only the functions needed by the driver interface.     *
 *                                                                             *
 *   Theses functions contain no real logic themselves. They do nothing but    *
 *   wrapping some arguments and forwarding the calls to the corresponding     *
 *   Pancake methods.                                                          *
 *                                                                             *
 * ========================================================================== */

// swiftlint:disable identifier_name function_parameter_count

/// The Pancake instance used for all external calls. Changeable for testing.
private var _pancakeInstance: Pancake = Pancake.shared

/// The global driver interface
private var _driverInterface: AudioServerPlugInDriverInterface?
private var _driverInterfacePointer: UnsafeMutablePointer<AudioServerPlugInDriverInterface>?
private var _driverReference: AudioServerPlugInDriverRef?


extension Pancake {
    public static var driverReference: AudioServerPlugInDriverRef {
        if let driverReference = _driverReference {
            return driverReference
        }

        _driverInterface = AudioServerPlugInDriverInterface(
            _reserved:                        nil,
            QueryInterface:                   Pancake_queryInterface,
            AddRef:                           Pancake_addRef,
            Release:                          Pancake_release,
            Initialize:                       Pancake_initialize,
            CreateDevice:                     Pancake_createDevice,
            DestroyDevice:                    Pancake_destroyDevice,
            AddDeviceClient:                  Pancake_addDeviceClient,
            RemoveDeviceClient:               Pancake_removeDeviceClient,
            PerformDeviceConfigurationChange: Pancake_performDeviceConfigurationChange,
            AbortDeviceConfigurationChange:   Pancake_abortDeviceConfigurationChange,
            HasProperty:                      Pancake_hasProperty,
            IsPropertySettable:               Pancake_isPropertySettable,
            GetPropertyDataSize:              Pancake_getPropertyDataSize,
            GetPropertyData:                  Pancake_getPropertyData,
            SetPropertyData:                  Pancake_setPropertyData,
            StartIO:                          Pancake_startIO,
            StopIO:                           Pancake_stopIO,
            GetZeroTimeStamp:                 Pancake_getZeroTimeStamp,
            WillDoIOOperation:                Pancake_willDoIOOperation,
            BeginIOOperation:                 Pancake_beginIOOperation,
            DoIOOperation:                    Pancake_doIOOperation,
            EndIOOperation:                   Pancake_endIOOperation
        )
        _driverInterfacePointer = withUnsafeMutablePointer(to: &_driverInterface!) { $0 }
        let driverReference        = withUnsafeMutablePointer(to: &_driverInterfacePointer) { $0 }
        _driverReference = driverReference

        return driverReference
    }
}


// MARK: - Inheritance

// The IUnknown method for interface discovery.
func Pancake_queryInterface(inDriver: UnsafeMutableRawPointer?, inUUID: REFIID, outInterface: UnsafeMutablePointer<LPVOID?>?) -> HRESULT {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    let uuid = UUID(from: inUUID)
    let interface = PluginInterface(from: outInterface)
    return _pancakeInstance.queryInterface(UUID: uuid, writeTo: interface)
}

// The IUnknown method for retaining a reference to a CFPlugIn type.
func Pancake_addRef(inDriver: UnsafeMutableRawPointer?) -> ULONG {
    guard validate(inDriver) else { return UInt32(PancakeAudioHardwareError.badObject) }
    return _pancakeInstance.addRef()
}

// The IUnknown method for releasing a reference to a CFPlugIn type.
func Pancake_release(inDriver: UnsafeMutableRawPointer?) -> ULONG {
    guard validate(inDriver) else { return UInt32(PancakeAudioHardwareError.badObject) }
    return _pancakeInstance.release()
}



// MARK: - Basic Operations

// This method is called to initialize the instance of the plug-in.
func Pancake_initialize(inDriver: AudioServerPlugInDriverRef, inHost: AudioServerPlugInHostRef) -> OSStatus {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    let host = AudioServerPlugInHost(from: inHost)
    return _pancakeInstance.initialize(host: host)
}

// Tells the plug-in to create a new device based on the given description.
func Pancake_createDevice(inDriver: AudioServerPlugInDriverRef, inDescription: CFDictionary, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>, outDeviceObjectID: UnsafeMutablePointer<AudioObjectID>) -> OSStatus {
    return _pancakeInstance.createDevice()
}

// Called to tell the plug-in about to destroy the given device.
func Pancake_destroyDevice(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID) -> OSStatus {
    return _pancakeInstance.destroyDevice()
}

// Called to tell the plug-in about a new client of the Host for a particular device.
func Pancake_addDeviceClient(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    return _pancakeInstance.addDeviceClient(deviceID: inDeviceObjectID, client: inClientInfo.pointee)
}

// Called to tell the plug-in about a client that is no longer using the device.
func Pancake_removeDeviceClient(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    return _pancakeInstance.removeDeviceClient(deviceID: inDeviceObjectID, client: inClientInfo.pointee)
}

// This is called by the Host to allow the device to perform a configuration change that had been previously requested via a call to the Host method, RequestDeviceConfigurationChange().
func Pancake_performDeviceConfigurationChange(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inChangeAction: UInt64, inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    return _pancakeInstance.performDeviceConfigurationChange(deviceID: inDeviceObjectID, action: inChangeAction)
}

// This is called by the Host to tell the plug-in not to perform a configuration change that had been requested via a call to the Host method, RequestDeviceConfigurationChange().
func Pancake_abortDeviceConfigurationChange(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inChangeAction: UInt64, inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    return _pancakeInstance.abortDeviceConfigurationChange(deviceID: inDeviceObjectID, action: inChangeAction)
}



// MARK: - Property Operations

// Queries an object about whether or not it has the given property.
func Pancake_hasProperty(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>) -> DarwinBoolean {
    guard validate(inDriver) else { return false }
    let propertyDescription = PancakeObjectPropertyDescription(with: inAddress.pointee)
    let hasProperty = _pancakeInstance.hasProperty(objectID: inObjectID, description: propertyDescription)
    return DarwinBoolean(hasProperty)
}

// Queries an object about whether or not the given property can be set.
func Pancake_isPropertySettable(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, outIsSettable: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus {
    return _pancakeInstance.isPropertySettable(inDriver: inDriver, inObjectID: inObjectID, inClientProcessID: inClientProcessID, inAddress: inAddress, outIsSettable: outIsSettable)
}

// Queries an object to find the size of the data for the given property.
func Pancake_getPropertyDataSize(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, outDataSize: UnsafeMutablePointer<UInt32>) -> OSStatus {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    let propertyDescription = PancakeObjectPropertyDescription(with: inAddress.pointee)
    return _pancakeInstance.getPropertyData(objectID: inObjectID, description: propertyDescription, dataSize: nil, outData: nil, outDataSize: outDataSize)
}

// Fetches the data of the given property and places it in the provided buffer.
func Pancake_getPropertyData(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, inDataSize: UInt32, outDataSize: UnsafeMutablePointer<UInt32>, outData: UnsafeMutableRawPointer) -> OSStatus {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    let propertyDescription = PancakeObjectPropertyDescription(with: inAddress.pointee)
    return _pancakeInstance.getPropertyData(objectID: inObjectID, description: propertyDescription, dataSize: inDataSize, outData: outData, outDataSize: outDataSize)
}

// Tells an object to change the value of the given property.
func Pancake_setPropertyData(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, inDataSize: UInt32, inData: UnsafeRawPointer) -> OSStatus {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    let propertyDescription = PancakeObjectPropertyDescription(with: inAddress.pointee)
    return _pancakeInstance.setPropertyData(objectID: inObjectID, description: propertyDescription, dataSize: inDataSize, data: inData)
}



// MARK: - IO Operations

// Tells the device to start IO.
func Pancake_startIO(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32) -> OSStatus {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    return _pancakeInstance.startIO(objectID: inDeviceObjectID, clientID: inClientID)
}


// Tells the device to stop IO.
func Pancake_stopIO(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32) -> OSStatus {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    return _pancakeInstance.stopIO(objectID: inDeviceObjectID, clientID: inClientID)
}

// Retrieves the most recent zero time stamp for the device.
func Pancake_getZeroTimeStamp(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, outSampleTime: UnsafeMutablePointer<Float64>, outHostTime: UnsafeMutablePointer<UInt64>, outSeed: UnsafeMutablePointer<UInt64>) -> OSStatus {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    return _pancakeInstance.getZeroTimeStamp(objectID: inDeviceObjectID, clientID: inClientID, outSampleTime: outSampleTime, outHostTime: outHostTime, outSeed: outSeed)
}


// Asks the plug-in whether or not the device will perform the given phase of the IO cycle for a particular device.
func Pancake_willDoIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, outWillDo: UnsafeMutablePointer<DarwinBoolean>, outWillDoInPlace: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    let operation = AudioServerPlugInIOOperation(rawValue: inOperationID)
    return _pancakeInstance.willDoIOOperation(objectID: inDeviceObjectID, clientID: inClientID, operation: operation, outWillDo: outWillDo, outWillDoInPlace: outWillDoInPlace)
}

// Tells the plug-in that the Host is about to begin a phase of the IO cycle for a particular device.
func Pancake_beginIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    return _pancakeInstance.beginIOOperation(objectID: inDeviceObjectID, clientID: inClientID, inOperationID: inOperationID, inIOBufferFrameSize: inIOBufferFrameSize, inIOCycleInfo: inIOCycleInfo)
}

// Tells the device to perform an IO operation for a particular stream.
func Pancake_doIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inStreamObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>, ioMainBuffer: UnsafeMutableRawPointer?, ioSecondaryBuffer: UnsafeMutableRawPointer?) -> OSStatus {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    let operation = AudioServerPlugInIOOperation(rawValue: inOperationID)
    let cycleInfo = inIOCycleInfo.pointee
    return _pancakeInstance.doIOOperation(deviceID: inDeviceObjectID, clientID: inClientID, streamID: inStreamObjectID, operation: operation, IOBufferFrameSize: inIOBufferFrameSize, IOCycleInfo: cycleInfo, mainBuffer: ioMainBuffer, secondaryBuffer: ioSecondaryBuffer)
}

// Tells the plug-in that the Host is about to end a phase of the IO cycle for a particular device.
func Pancake_endIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus {
    guard validate(inDriver) else { return PancakeAudioHardwareError.badObject }
    let operation = AudioServerPlugInIOOperation(rawValue: inOperationID)
    let cycleInfo = inIOCycleInfo.pointee
    return _pancakeInstance.endIOOperation(deviceID: inDeviceObjectID, clientID: inClientID, operation: operation, IOBufferFrameSize: inIOBufferFrameSize, IOCycleInfo: cycleInfo)
}




func validate(_ driverPointer: UnsafeMutableRawPointer?, referenceDriver: AudioServerPlugInDriver = _pancakeInstance.driver) -> Bool {
    guard let driverPointer = driverPointer else { return false }
    let driver = AudioServerPlugInDriver(from: driverPointer)
    let isValid = (driver == referenceDriver)
    if !isValid { assertionFailure() }
    return isValid
}
