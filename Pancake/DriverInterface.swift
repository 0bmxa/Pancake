//
//  DriverInterface.swift
//  Pancake
//
//  Created by mxa on 20.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn


// MARK: - Inheritance

func Pancake_queryInterface(inDriver: UnsafeMutableRawPointer?, inUUID: REFIID, outInterface: UnsafeMutablePointer<LPVOID?>?) -> HRESULT {
    let driver = AudioServerPlugInDriver(from: inDriver)
    let UUID = CFUUIDCreateFromUUIDBytes(nil, inUUID)
    let interface = PluginInterface(from: outInterface)
    return Pancake.shared.queryInterface(driver: driver, UUID: UUID, writeTo: interface)
}

func Pancake_addRef(inDriver: UnsafeMutableRawPointer?) -> ULONG {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return Pancake.shared.addRef(driver: driver)
}

func Pancake_release(inDriver: UnsafeMutableRawPointer?) -> ULONG {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return Pancake.shared.release(driver: driver)
}



// MARK: - Basic Operations

func Pancake_initialize(inDriver: AudioServerPlugInDriverRef, inHost: AudioServerPlugInHostRef) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    let host = AudioServerPlugInHost(from: inHost)
    return Pancake.shared.initialize(driver: driver, host: host)
}

func Pancake_createDevice(inDriver: AudioServerPlugInDriverRef, inDescription: CFDictionary, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>, outDeviceObjectID: UnsafeMutablePointer<AudioObjectID>) -> OSStatus {
    return Pancake.shared.createDevice()
}

func Pancake_destroyDevice(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID) -> OSStatus {
    return Pancake.shared.destroyDevice()
}

func Pancake_addDeviceClient(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus {
    return Pancake.shared.addDeviceClient()
}

func Pancake_removeDeviceClient(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus {
    return Pancake.shared.removeDeviceClient()
}

func Pancake_performDeviceConfigurationChange(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inChangeAction: UInt64, inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return Pancake.shared.performDeviceConfigurationChange(driver: driver, deviceObjectID: inDeviceObjectID, changeAction: inChangeAction)
}

func Pancake_abortDeviceConfigurationChange(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inChangeAction: UInt64, inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return Pancake.shared.abortDeviceConfigurationChange(driver: driver, inDeviceObjectID: inDeviceObjectID, inChangeAction: inChangeAction)
}



// MARK: - Property Operations

func Pancake_hasProperty(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>) -> DarwinBoolean {
    let driver = AudioServerPlugInDriver(from: inDriver)
    let propertyAddress = PropertyAddress(from: inAddress)
    let hasProperty = Pancake.shared.hasProperty(driver: driver, objectID: inObjectID, propertyAddress: propertyAddress)
    return DarwinBoolean(hasProperty)
}

func Pancake_isPropertySettable(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, outIsSettable: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus {
    return Pancake.shared.isPropertySettable(inDriver: inDriver, inObjectID: inObjectID, inClientProcessID: inClientProcessID, inAddress: inAddress, outIsSettable: outIsSettable)
}
func Pancake_getPropertyDataSize(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, outDataSize: UnsafeMutablePointer<UInt32>) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return Pancake.shared.getPropertyData(driver: driver, objectID: inObjectID, propertyAddress: inAddress, dataSize: nil, outData: nil, outDataSize: outDataSize)
}
func Pancake_getPropertyData(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, inDataSize: UInt32, outDataSize: UnsafeMutablePointer<UInt32>, outData: UnsafeMutableRawPointer) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return Pancake.shared.getPropertyData(driver: driver, objectID: inObjectID, propertyAddress: inAddress, dataSize: inDataSize, outData: outData, outDataSize: outDataSize)
}
func Pancake_setPropertyData(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, inDataSize: UInt32, inData: UnsafeRawPointer) -> OSStatus {
    return Pancake.shared.setPropertyData(inDriver: inDriver, inObjectID: inObjectID, inClientProcessID: inClientProcessID, inAddress: inAddress, inQualifierDataSize: inQualifierDataSize, inQualifierData: inQualifierData, inDataSize: inDataSize, inData: inData)
}



// MARK: - IO Operations

func Pancake_startIO(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32) -> OSStatus {
    return Pancake.shared.startIO(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID)
}
func Pancake_stopIO(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32) -> OSStatus {
    return Pancake.shared.stopIO(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID)
}
func Pancake_getZeroTimeStamp(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, outSampleTime: UnsafeMutablePointer<Float64>, outHostTime: UnsafeMutablePointer<UInt64>, outSeed: UnsafeMutablePointer<UInt64>) -> OSStatus {
    return Pancake.shared.getZeroTimeStamp(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID, outSampleTime: outSampleTime, outHostTime: outHostTime, outSeed: outSeed)
}
func Pancake_willDoIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, outWillDo: UnsafeMutablePointer<DarwinBoolean>, outWillDoInPlace: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus {
    return Pancake.shared.willDoIOOperation(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID, inOperationID: inOperationID, outWillDo: outWillDo, outWillDoInPlace: outWillDoInPlace)
}
func Pancake_beginIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus {
    return Pancake.shared.beginIOOperation(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID, inOperationID: inOperationID, inIOBufferFrameSize: inIOBufferFrameSize, inIOCycleInfo: inIOCycleInfo)
}
func Pancake_doIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inStreamObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>, ioMainBuffer: UnsafeMutableRawPointer?, ioSecondaryBuffer: UnsafeMutableRawPointer?) -> OSStatus {
    return Pancake.shared.doIOOperation(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inStreamObjectID: inStreamObjectID, inClientID: inClientID, inOperationID: inOperationID, inIOBufferFrameSize: inIOBufferFrameSize, inIOCycleInfo: inIOCycleInfo, ioMainBuffer: ioMainBuffer, ioSecondaryBuffer: ioSecondaryBuffer)
}
func Pancake_endIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus {
    return Pancake.shared.endIOOperation(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID, inOperationID: inOperationID, inIOBufferFrameSize: inIOBufferFrameSize, inIOCycleInfo: inIOCycleInfo)
}
