//
//  DriverInterface.swift
//  Pancake
//
//  Created by mxa on 20.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

let pancake = Pancake()

// MARK: - Inheritance
func Pancake_queryInterface(inDriver: UnsafeMutableRawPointer?, inUUID: REFIID, outInterface: UnsafeMutablePointer<LPVOID?>?) -> HRESULT {
    return pancake.queryInterface(inDriver: inDriver, inUUID: inUUID, outInterface: outInterface)
}
func Pancake_addRef(inDriver: UnsafeMutableRawPointer?) -> ULONG {
    return Pancake.addRef(inDriver: inDriver)
}
func Pancake_release(inDriver: UnsafeMutableRawPointer?) -> ULONG {
    return Pancake.release(inDriver: inDriver)
}



// MARK: - Basic Operations

func Pancake_initialize(inDriver: AudioServerPlugInDriverRef, inHost: AudioServerPlugInHostRef) -> OSStatus {
    return Pancake.initialize(inDriver: inDriver, inHost: inHost)
}
func Pancake_createDevice(inDriver: AudioServerPlugInDriverRef, inDescription: CFDictionary, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>, outDeviceObjectID: UnsafeMutablePointer<AudioObjectID>) -> OSStatus {
    return Pancake.createDevice(inDriver: inDriver, inDescription: inDescription, inClientInfo: inClientInfo, outDeviceObjectID: outDeviceObjectID)
}
func Pancake_destroyDevice(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID) -> OSStatus {
    return Pancake.destroyDevice(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID)
}
func Pancake_addDeviceClient(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus {
    return Pancake.addDeviceClient(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientInfo: inClientInfo)
}
func Pancake_removeDeviceClient(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus {
    return Pancake.removeDeviceClient(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientInfo: inClientInfo)
}
func Pancake_performDeviceConfigurationChange(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inChangeAction: UInt64, inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus {
    return Pancake.performDeviceConfigurationChange(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inChangeAction: inChangeAction, inChangeInfo: inChangeInfo)
}
func Pancake_abortDeviceConfigurationChange(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inChangeAction: UInt64, inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus {
    return Pancake.abortDeviceConfigurationChange(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inChangeAction: inChangeAction, inChangeInfo: inChangeInfo)
}



// MARK: - Property Operations


func Pancake_hasProperty(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>) -> DarwinBoolean {
    return Pancake.hasProperty(inDriver: inDriver, inObjectID: inObjectID, inClientProcessID: inClientProcessID, inAddress: inAddress)
}
func Pancake_isPropertySettable(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, outIsSettable: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus {
    return Pancake.isPropertySettable(inDriver: inDriver, inObjectID: inObjectID, inClientProcessID: inClientProcessID, inAddress: inAddress, outIsSettable: outIsSettable)
}
func Pancake_getPropertyDataSize(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inAddress: pid_t, inClientProcessID: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, outDataSize: UnsafeMutablePointer<UInt32>) -> OSStatus {
    return Pancake.getPropertyDataSize(inDriver: inDriver, inObjectID: inObjectID, inAddress: inAddress, inClientProcessID: inClientProcessID, inQualifierDataSize: inQualifierDataSize, inQualifierData: inQualifierData, outDataSize: outDataSize)
}
func Pancake_getPropertyData(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, inDataSize: UInt32, outDataSize: UnsafeMutablePointer<UInt32>, outData: UnsafeMutableRawPointer) -> OSStatus {
    return Pancake.getPropertyData(inDriver: inDriver, inObjectID: inObjectID, inClientProcessID: inClientProcessID, inAddress: inAddress, inQualifierDataSize: inQualifierDataSize, inQualifierData: inQualifierData, inDataSize: inDataSize, outDataSize: outDataSize, outData: outData)
}
func Pancake_setPropertyData(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, inDataSize: UInt32, inData: UnsafeRawPointer) -> OSStatus {
    return Pancake.setPropertyData(inDriver: inDriver, inObjectID: inObjectID, inClientProcessID: inClientProcessID, inAddress: inAddress, inQualifierDataSize: inQualifierDataSize, inQualifierData: inQualifierData, inDataSize: inDataSize, inData: inData)
}



// MARK: - IO Operations

func Pancake_startIO(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32) -> OSStatus {
    return Pancake.startIO(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID)
}
func Pancake_stopIO(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32) -> OSStatus {
    return Pancake.stopIO(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID)
}
func Pancake_getZeroTimeStamp(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, outSampleTime: UnsafeMutablePointer<Float64>, outHostTime: UnsafeMutablePointer<UInt64>, outSeed: UnsafeMutablePointer<UInt64>) -> OSStatus {
    return Pancake.getZeroTimeStamp(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID, outSampleTime: outSampleTime, outHostTime: outHostTime, outSeed: outSeed)
}
func Pancake_willDoIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, outWillDo: UnsafeMutablePointer<DarwinBoolean>, outWillDoInPlace: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus {
    return Pancake.willDoIOOperation(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID, inOperationID: inOperationID, outWillDo: outWillDo, outWillDoInPlace: outWillDoInPlace)
}
func Pancake_beginIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus {
    return Pancake.beginIOOperation(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID, inOperationID: inOperationID, inIOBufferFrameSize: inIOBufferFrameSize, inIOCycleInfo: inIOCycleInfo)
}
func Pancake_doIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inStreamObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>, ioMainBuffer: UnsafeMutableRawPointer?, ioSecondaryBuffer: UnsafeMutableRawPointer?) -> OSStatus {
    return Pancake.doIOOperation(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inStreamObjectID: inStreamObjectID, inClientID: inClientID, inOperationID: inOperationID, inIOBufferFrameSize: inIOBufferFrameSize, inIOCycleInfo: inIOCycleInfo, ioMainBuffer: ioMainBuffer, ioSecondaryBuffer: ioSecondaryBuffer)
}
func Pancake_endIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus {
    return Pancake.endIOOperation(inDriver: inDriver, inDeviceObjectID: inDeviceObjectID, inClientID: inClientID, inOperationID: inOperationID, inIOBufferFrameSize: inIOBufferFrameSize, inIOCycleInfo: inIOCycleInfo)
}
