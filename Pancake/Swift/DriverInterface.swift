//
//  DriverInterface.swift
//  Pancake
//
//  Created by mxa on 20.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn


// MARK: - Inheritance
class Pancake {
    
    static var driverInterface: UnsafeMutablePointer<AudioServerPlugInDriverInterface>? = nil
    
    func queryInterface(inDriver: UnsafeMutableRawPointer?, inUUID: REFIID, outInterface: UnsafeMutablePointer<LPVOID?>?) -> HRESULT {
        guard let inDriver = inDriver else { return -1 }
        let driver = AudioServerPlugInDriverRef(inDriver)
        return PancakeInheritance().queryInterface(driver: driver, UUID: inUUID, interface: &outInterface)
        return 0
    }
    static func addRef(inDriver: UnsafeMutableRawPointer?) -> ULONG {
        return 0
    }
    static func release(inDriver: UnsafeMutableRawPointer?) -> ULONG {
        return 0
    }
    
    
    
    // MARK: - Basic Operations
    
    static func initialize(inDriver: AudioServerPlugInDriverRef, inHost: AudioServerPlugInHostRef) -> OSStatus {
        return 0
    }
    static func createDevice(inDriver: AudioServerPlugInDriverRef, inDescription: CFDictionary, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>, outDeviceObjectID: UnsafeMutablePointer<AudioObjectID>) -> OSStatus {
        return 0
    }
    static func destroyDevice(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID) -> OSStatus {
        return 0
    }
    static func addDeviceClient(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus {
        return 0
    }
    static func removeDeviceClient(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus {
        return 0
    }
    static func performDeviceConfigurationChange(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inChangeAction: UInt64, inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus {
        return 0
    }
    static func abortDeviceConfigurationChange(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inChangeAction: UInt64, inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus {
        return 0
    }
    
    
    
    // MARK: - Property Operations
    
    
    static func hasProperty(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>) -> DarwinBoolean {
        return false
    }
    static func isPropertySettable(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, outIsSettable: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus {
        return 0
    }
    static func getPropertyDataSize(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inAddress: pid_t, inClientProcessID: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, outDataSize: UnsafeMutablePointer<UInt32>) -> OSStatus {
        return 0
    }
    static func getPropertyData(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, inDataSize: UInt32, outDataSize: UnsafeMutablePointer<UInt32>, outData: UnsafeMutableRawPointer) -> OSStatus {
        return 0
    }
    static func setPropertyData(inDriver: AudioServerPlugInDriverRef, inObjectID: AudioObjectID, inClientProcessID: pid_t, inAddress: UnsafePointer<AudioObjectPropertyAddress>, inQualifierDataSize: UInt32, inQualifierData: UnsafeRawPointer?, inDataSize: UInt32, inData: UnsafeRawPointer) -> OSStatus {
        return 0
    }
    
    
    
    // MARK: - IO Operations
    
    static func startIO(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32) -> OSStatus {
        return 0
    }
    static func stopIO(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32) -> OSStatus {
        return 0
    }
    static func getZeroTimeStamp(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, outSampleTime: UnsafeMutablePointer<Float64>, outHostTime: UnsafeMutablePointer<UInt64>, outSeed: UnsafeMutablePointer<UInt64>) -> OSStatus {
        return 0
    }
    static func willDoIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, outWillDo: UnsafeMutablePointer<DarwinBoolean>, outWillDoInPlace: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus {
        return 0
    }
    static func beginIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus {
        return 0
    }
    static func doIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inStreamObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>, ioMainBuffer: UnsafeMutableRawPointer?, ioSecondaryBuffer: UnsafeMutableRawPointer?) -> OSStatus {
        return 0
    }
    static func endIOOperation(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientID: UInt32, inOperationID: UInt32, inIOBufferFrameSize: UInt32, inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus {
        return 0
    }
}
