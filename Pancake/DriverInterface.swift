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
 

// MARK: - Inheritance

// The IUnknown method for interface discovery.
func Pancake_queryInterface(inDriver: UnsafeMutableRawPointer?, inUUID: REFIID, outInterface: UnsafeMutablePointer<LPVOID?>?) -> HRESULT {
    let driver = AudioServerPlugInDriver(from: inDriver)
    let uuid = UUID(from: inUUID)
    let interface = PluginInterface(from: outInterface)
    return Pancake.shared.queryInterface(driver: driver, UUID: uuid, writeTo: interface)
}

// The IUnknown method for retaining a reference to a CFPlugIn type.
func Pancake_addRef(inDriver: UnsafeMutableRawPointer?) -> ULONG {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return Pancake.shared.addRef(driver: driver)
}

// The IUnknown method for releasing a reference to a CFPlugIn type.
func Pancake_release(inDriver: UnsafeMutableRawPointer?) -> ULONG {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return Pancake.shared.release(driver: driver)
}



// MARK: - Basic Operations

// This method is called to initialize the instance of the plug-in.
func Pancake_initialize(inDriver: AudioServerPlugInDriverRef, inHost: AudioServerPlugInHostRef) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    let host = AudioServerPlugInHost(from: inHost)
    return Pancake.shared.initialize(driver: driver, host: host)
}

// Tells the plug-in to create a new device based on the given description.
func Pancake_createDevice(inDriver: AudioServerPlugInDriverRef, inDescription: CFDictionary, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>, outDeviceObjectID: UnsafeMutablePointer<AudioObjectID>) -> OSStatus {
    return Pancake.shared.createDevice()
}

// Called to tell the plug-in about to destroy the given device.
func Pancake_destroyDevice(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID) -> OSStatus {
    return Pancake.shared.destroyDevice()
}

// Called to tell the plug-in about a new client of the Host for a particular device.
func Pancake_addDeviceClient(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus {
    return Pancake.shared.addDeviceClient()
}

// Called to tell the plug-in about a client that is no longer using the device.
func Pancake_removeDeviceClient(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus {
    return Pancake.shared.removeDeviceClient()
}

// This is called by the Host to allow the device to perform a configuration change that had been previously requested via a call to the Host method, RequestDeviceConfigurationChange().
func Pancake_performDeviceConfigurationChange(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inChangeAction: UInt64, inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return Pancake.shared.performDeviceConfigurationChange(driver: driver, deviceObjectID: inDeviceObjectID, changeAction: inChangeAction)
}

// This is called by the Host to tell the plug-in not to perform a configuration change that had been requested via a call to the Host method, RequestDeviceConfigurationChange().
func Pancake_abortDeviceConfigurationChange(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inChangeAction: UInt64, inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return Pancake.shared.abortDeviceConfigurationChange(driver: driver, inDeviceObjectID: inDeviceObjectID, inChangeAction: inChangeAction)
}



// MARK: - Property Operations

// Queries an object about whether or not it has the given property.
func Pancake_hasProperty(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>) -> DarwinBoolean {
    let driver = AudioServerPlugInDriver(from: inDriver)
    let propertyDescription = PancakeObjectPropertyDescription(with: inAddress.pointee)
    let hasProperty = Pancake.shared.hasProperty(driver: driver, objectID: inObjectID, description: propertyDescription)
    return DarwinBoolean(hasProperty)
}

// Queries an object about whether or not the given property can be set.
func Pancake_isPropertySettable(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, outIsSettable: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus {
    return Pancake.shared.isPropertySettable(inDriver: inDriver, inObjectID: inObjectID, inClientProcessID: inClientProcessID, inAddress: inAddress, outIsSettable: outIsSettable)
}

// Queries an object to find the size of the data for the given property.
func Pancake_getPropertyDataSize(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, outDataSize: UnsafeMutablePointer<UInt32>) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    let propertyDescription = PancakeObjectPropertyDescription(with: inAddress.pointee)
    return Pancake.shared.getPropertyData(driver: driver, objectID: inObjectID, description: propertyDescription, dataSize: nil, outData: nil, outDataSize: outDataSize)
}

// Fetches the data of the given property and places it in the provided buffer.
func Pancake_getPropertyData(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, inDataSize: UInt32, outDataSize: UnsafeMutablePointer<UInt32>, outData: UnsafeMutableRawPointer) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    let propertyDescription = PancakeObjectPropertyDescription(with: inAddress.pointee)
    return Pancake.shared.getPropertyData(driver: driver, objectID: inObjectID, description: propertyDescription, dataSize: inDataSize, outData: outData, outDataSize: outDataSize)
}

// Tells an object to change the value of the given property.
func Pancake_setPropertyData(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, inDataSize: UInt32, inData: UnsafeRawPointer) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    let propertyDescription = PancakeObjectPropertyDescription(with: inAddress.pointee)
    return Pancake.shared.setPropertyData(driver: driver, objectID: inObjectID, description: propertyDescription, dataSize: inDataSize, data: inData)
}



// MARK: - IO Operations

// Tells the device to start IO.
func Pancake_startIO(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return Pancake.shared.startIO(driver: driver, objectID: inDeviceObjectID, clientID: inClientID)
}


// Tells the device to stop IO.
func Pancake_stopIO(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return Pancake.shared.stopIO(driver: driver, objectID: inDeviceObjectID, clientID: inClientID)
}

// Retrieves the most recent zero time stamp for the device.
func Pancake_getZeroTimeStamp(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, outSampleTime: UnsafeMutablePointer<Float64>, outHostTime: UnsafeMutablePointer<UInt64>, outSeed: UnsafeMutablePointer<UInt64>) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return Pancake.shared.getZeroTimeStamp(driver: driver, objectID: inDeviceObjectID, clientID: inClientID, outSampleTime: outSampleTime, outHostTime: outHostTime, outSeed: outSeed)
}


// Asks the plug-in whether or not the device will perform the given phase of the IO cycle for a particular device.
func Pancake_willDoIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, outWillDo: UnsafeMutablePointer<DarwinBoolean>, outWillDoInPlace: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    let operation = AudioServerPlugInIOOperation(rawValue: inOperationID)
    return Pancake.shared.willDoIOOperation(driver: driver, objectID: inDeviceObjectID, clientID: inClientID, operation: operation, outWillDo: outWillDo, outWillDoInPlace: outWillDoInPlace)
}

// Tells the plug-in that the Host is about to begin a phase of the IO cycle for a particular device.
func Pancake_beginIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return Pancake.shared.beginIOOperation(driver: driver, objectID: inDeviceObjectID, clientID: inClientID, inOperationID: inOperationID, inIOBufferFrameSize: inIOBufferFrameSize, inIOCycleInfo: inIOCycleInfo)
}

// Tells the device to perform an IO operation for a particular stream.
func Pancake_doIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inStreamObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>, ioMainBuffer: UnsafeMutableRawPointer?, ioSecondaryBuffer: UnsafeMutableRawPointer?) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    let operation = AudioServerPlugInIOOperation(rawValue: inOperationID)
    return Pancake.shared.doIOOperation(driver: driver, deviceObjectID: inDeviceObjectID, clientID: inClientID, streamObjectID: inStreamObjectID, operation: operation, IOBufferFrameSize: inIOBufferFrameSize, IOCycleInfo: inIOCycleInfo, mainBuffer: ioMainBuffer, secondaryBuffer: ioSecondaryBuffer)
}

// Tells the plug-in that the Host is about to end a phase of the IO cycle for a particular device.
func Pancake_endIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return Pancake.shared.endIOOperation(driver: driver, objectID: inDeviceObjectID, clientID: inClientID, inOperationID: inOperationID, inIOBufferFrameSize: inIOBufferFrameSize, inIOCycleInfo: inIOCycleInfo)
}
