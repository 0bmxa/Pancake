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
    return pancake!.queryInterface(driver: driver, UUID: UUID, writeTo: interface)
}

func Pancake_addRef(inDriver: UnsafeMutableRawPointer?) -> ULONG {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return pancake!.addRef(driver: driver)
}

func Pancake_release(inDriver: UnsafeMutableRawPointer?) -> ULONG {
    let driver = AudioServerPlugInDriver(from: inDriver)
    return pancake!.release(driver: driver)
}



// MARK: - Basic Operations

func Pancake_initialize(inDriver: AudioServerPlugInDriverRef, inHost: AudioServerPlugInHostRef) -> OSStatus {
    let driver = AudioServerPlugInDriver(from: inDriver)
    let host = AudioServerPlugInHost(from: inHost)
    return pancake!.initialize(driver: driver, host: host)
}
func Pancake_createDevice(inDriver: AudioServerPlugInDriverRef, inDescription: CFDictionary, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>, outDeviceObjectID: UnsafeMutablePointer<AudioObjectID>) -> OSStatus {
    return pancake!.createDevice(inDriver: inDriver, inDescription: inDescription, inClientInfo: inClientInfo, outDeviceObjectID: outDeviceObjectID)
}
func Pancake_destroyDevice(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID) -> OSStatus {
    return pancake!.destroyDevice(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID)
}
func Pancake_addDeviceClient(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus {
    return pancake!.addDeviceClient(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientInfo: inClientInfo)
}
func Pancake_removeDeviceClient(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus {
    return pancake!.removeDeviceClient(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientInfo: inClientInfo)
}
func Pancake_performDeviceConfigurationChange(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inChangeAction: UInt64, inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus {
    return pancake!.performDeviceConfigurationChange(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inChangeAction: inChangeAction, inChangeInfo: inChangeInfo)
}
func Pancake_abortDeviceConfigurationChange(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inChangeAction: UInt64, inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus {
    return pancake!.abortDeviceConfigurationChange(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inChangeAction: inChangeAction, inChangeInfo: inChangeInfo)
}



// MARK: - Property Operations

func Pancake_hasProperty(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>) -> DarwinBoolean {
    return pancake!.hasProperty(inDriver: inDriver, inObjectID: inObjectID, inClientProcessID: inClientProcessID, inAddress: inAddress)
}
func Pancake_isPropertySettable(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, outIsSettable: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus {
    return pancake!.isPropertySettable(inDriver: inDriver, inObjectID: inObjectID, inClientProcessID: inClientProcessID, inAddress: inAddress, outIsSettable: outIsSettable)
}
func Pancake_getPropertyDataSize(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inAddress: pid_t, inClientProcessID: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, outDataSize: UnsafeMutablePointer<UInt32>) -> OSStatus {
    return pancake!.getPropertyDataSize(inDriver: inDriver, inObjectID: inObjectID, inAddress: inAddress, inClientProcessID: inClientProcessID, inQualifierDataSize: inQualifierDataSize, inQualifierData: inQualifierData, outDataSize: outDataSize)
}
func Pancake_getPropertyData(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, inDataSize: UInt32, outDataSize: UnsafeMutablePointer<UInt32>, outData: UnsafeMutableRawPointer) -> OSStatus {
    return pancake!.getPropertyData(inDriver: inDriver, inObjectID: inObjectID, inClientProcessID: inClientProcessID, inAddress: inAddress, inQualifierDataSize: inQualifierDataSize, inQualifierData: inQualifierData, inDataSize: inDataSize, outDataSize: outDataSize, outData: outData)
}
func Pancake_setPropertyData(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, inDataSize: UInt32, inData: UnsafeRawPointer) -> OSStatus {
    return pancake!.setPropertyData(inDriver: inDriver, inObjectID: inObjectID, inClientProcessID: inClientProcessID, inAddress: inAddress, inQualifierDataSize: inQualifierDataSize, inQualifierData: inQualifierData, inDataSize: inDataSize, inData: inData)
}



// MARK: - IO Operations

func Pancake_startIO(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32) -> OSStatus {
    return pancake!.startIO(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID)
}
func Pancake_stopIO(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32) -> OSStatus {
    return pancake!.stopIO(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID)
}
func Pancake_getZeroTimeStamp(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, outSampleTime: UnsafeMutablePointer<Float64>, outHostTime: UnsafeMutablePointer<UInt64>, outSeed: UnsafeMutablePointer<UInt64>) -> OSStatus {
    return pancake!.getZeroTimeStamp(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID, outSampleTime: outSampleTime, outHostTime: outHostTime, outSeed: outSeed)
}
func Pancake_willDoIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, outWillDo: UnsafeMutablePointer<DarwinBoolean>, outWillDoInPlace: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus {
    return pancake!.willDoIOOperation(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID, inOperationID: inOperationID, outWillDo: outWillDo, outWillDoInPlace: outWillDoInPlace)
}
func Pancake_beginIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus {
    return pancake!.beginIOOperation(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID, inOperationID: inOperationID, inIOBufferFrameSize: inIOBufferFrameSize, inIOCycleInfo: inIOCycleInfo)
}
func Pancake_doIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inStreamObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>, ioMainBuffer: UnsafeMutableRawPointer?, ioSecondaryBuffer: UnsafeMutableRawPointer?) -> OSStatus {
    return pancake!.doIOOperation(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inStreamObjectID: inStreamObjectID, inClientID: inClientID, inOperationID: inOperationID, inIOBufferFrameSize: inIOBufferFrameSize, inIOCycleInfo: inIOCycleInfo, ioMainBuffer: ioMainBuffer, ioSecondaryBuffer: ioSecondaryBuffer)
}
func Pancake_endIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus {
    return pancake!.endIOOperation(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID, inOperationID: inOperationID, inIOBufferFrameSize: inIOBufferFrameSize, inIOCycleInfo: inIOCycleInfo)
}
