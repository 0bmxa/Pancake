//
//  AudioServerPlugInDriver.swift
//  Pancake
//
//  Created by mxa on 20.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn


// MARK: - AudioServerPlugInDriverRef
//struct AudioServerPlugInDriver {
//    static func reference(from interface: inout AudioServerPlugInDriverInterface) -> AudioServerPlugInDriverRef {
//        var driverInterfacePointer: UnsafeMutablePointer<AudioServerPlugInDriverInterface>? = withUnsafeMutablePointer(to: &interface) { return $0 }
//        let driverPointer: AudioServerPlugInDriverRef = withUnsafeMutablePointer(to: &driverInterfacePointer) { return $0 }
//        return driverPointer
//    }
//}

//func AudioServerPlugInDriverRef(from interface: inout AudioServerPlugInDriverInterface) -> AudioServerPlugInDriverRef {
//    var driverInterfacePointer: UnsafeMutablePointer<AudioServerPlugInDriverInterface>? = withUnsafeMutablePointer(to: &interface) { return $0 }
//    let driverPointer: AudioServerPlugInDriverRef = withUnsafeMutablePointer(to: &driverInterfacePointer) { return $0 }
//    return driverPointer
//}



// MARK: - Extension: AudioServerPlugInDriverInterface

extension AudioServerPlugInDriverInterface {
    
    typealias QueryInterfaceFunc = @convention(c) (_ inDriver: UnsafeMutableRawPointer?, _ inUUID: REFIID, _ outInterface: UnsafeMutablePointer<LPVOID?>?) -> HRESULT
    typealias AddRefFunc = @convention(c) (_ inDriver: UnsafeMutableRawPointer?) -> ULONG
    typealias ReleaseFunc = @convention(c) (_ inDriver: UnsafeMutableRawPointer?) -> ULONG
    typealias InitializeFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inHost: AudioServerPlugInHostRef) -> OSStatus
    typealias CreateDeviceFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inDescription: CFDictionary, _ inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>, _ outDeviceObjectID: UnsafeMutablePointer<AudioObjectID>) -> OSStatus
    typealias DestroyDeviceFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID) -> OSStatus
    typealias AddDeviceClientFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus
    typealias RemoveDeviceClientFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus
    typealias PerformDeviceConfigurationChangeFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inChangeAction: UInt64, _ inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus
    typealias AbortDeviceConfigurationChangeFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inChangeAction: UInt64, _ inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus
    typealias HasPropertyFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inObjectID: AudioObjectID, _ inClientProcessID: pid_t, _ inAddress: UnsafePointer<AudioObjectPropertyAddress>) -> DarwinBoolean
    typealias IsPropertySettableFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inObjectID: AudioObjectID, _ inClientProcessID: pid_t, _ inAddress: UnsafePointer<AudioObjectPropertyAddress>, _ outIsSettable: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus
    typealias GetPropertyDataSizeFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inObjectID: AudioObjectID, _ inAddress: pid_t, _ inClientProcessID: UnsafePointer<AudioObjectPropertyAddress>, _ inQualifierDataSize: UInt32, _ inQualifierData: UnsafeRawPointer?, _ outDataSize: UnsafeMutablePointer<UInt32>) -> OSStatus
    typealias GetPropertyDataFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inObjectID: AudioObjectID, _ inClientProcessID: pid_t, _ inAddress: UnsafePointer<AudioObjectPropertyAddress>, _ inQualifierDataSize: UInt32, _ inQualifierData: UnsafeRawPointer?, _ inDataSize: UInt32, _ outDataSize: UnsafeMutablePointer<UInt32>, _ outData: UnsafeMutableRawPointer) -> OSStatus
    typealias SetPropertyDataFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inObjectID: AudioObjectID, _ inClientProcessID: pid_t, _ inAddress: UnsafePointer<AudioObjectPropertyAddress>, _ inQualifierDataSize: UInt32, _ inQualifierData: UnsafeRawPointer?, _ inDataSize: UInt32, _ inData: UnsafeRawPointer) -> OSStatus
    typealias StartIOFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientID: UInt32) -> OSStatus
    typealias StopIOFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientID: UInt32) -> OSStatus
    typealias GetZeroTimeStampFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientID: UInt32, _ outSampleTime: UnsafeMutablePointer<Float64>, _ outHostTime: UnsafeMutablePointer<UInt64>, _ outSeed: UnsafeMutablePointer<UInt64>) -> OSStatus
    typealias WillDoIOOperationFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientID: UInt32, _ inOperationID: UInt32, _ outWillDo: UnsafeMutablePointer<DarwinBoolean>, _ outWillDoInPlace: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus
    typealias BeginIOOperationFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientID: UInt32, _ inOperationID: UInt32, _ inIOBufferFrameSize: UInt32, _ inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus
    typealias DoIOOperationFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inStreamObjectID: AudioObjectID, _ inClientID: UInt32, _ inOperationID: UInt32, _ inIOBufferFrameSize: UInt32, _ inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>, _ ioMainBuffer: UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> OSStatus
    typealias EndIOOperationFunc = @convention(c) (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientID: UInt32, _ inOperationID: UInt32, _ inIOBufferFrameSize: UInt32, _ inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus
    
}

extension AudioServerPlugInDriverInterface {

    init(queryInterface: @escaping QueryInterfaceFunc,
         addRef: @escaping AddRefFunc,
         release: @escaping ReleaseFunc,
         initialize: @escaping InitializeFunc,
         createDevice: @escaping CreateDeviceFunc,
         destroyDevice: @escaping DestroyDeviceFunc,
         addDeviceClient: @escaping AddDeviceClientFunc,
         removeDeviceClient: @escaping RemoveDeviceClientFunc,
         performDeviceConfigurationChange: @escaping PerformDeviceConfigurationChangeFunc,
         abortDeviceConfigurationChange: @escaping AbortDeviceConfigurationChangeFunc,
         hasProperty: @escaping HasPropertyFunc,
         isPropertySettable: @escaping IsPropertySettableFunc,
         getPropertyDataSize: @escaping GetPropertyDataSizeFunc,
         getPropertyData: @escaping GetPropertyDataFunc,
         setPropertyData: @escaping SetPropertyDataFunc,
         startIO: @escaping StartIOFunc,
         stopIO: @escaping StopIOFunc,
         getZeroTimeStamp: @escaping GetZeroTimeStampFunc,
         willDoIOOperation: @escaping WillDoIOOperationFunc,
         beginIOOperation: @escaping BeginIOOperationFunc,
         doIOOperation: @escaping DoIOOperationFunc,
         endIOOperation: @escaping EndIOOperationFunc
        )
    {
        self._reserved = nil
        self.QueryInterface = queryInterface
        self.AddRef = addRef
        self.Release = release
        self.Initialize = initialize
        self.CreateDevice = createDevice
        self.DestroyDevice = destroyDevice
        self.AddDeviceClient = addDeviceClient
        self.RemoveDeviceClient = removeDeviceClient
        self.PerformDeviceConfigurationChange = performDeviceConfigurationChange
        self.AbortDeviceConfigurationChange = abortDeviceConfigurationChange
        self.HasProperty = hasProperty
        self.IsPropertySettable = isPropertySettable
        self.GetPropertyDataSize = getPropertyDataSize
        self.GetPropertyData = getPropertyData
        self.SetPropertyData = setPropertyData
        self.StartIO = startIO
        self.StopIO = stopIO
        self.GetZeroTimeStamp = getZeroTimeStamp
        self.WillDoIOOperation = willDoIOOperation
        self.BeginIOOperation = beginIOOperation
        self.DoIOOperation = doIOOperation
        self.EndIOOperation = endIOOperation
    }


    init() {
        self._reserved = nil
        self.QueryInterface = { _ -> HRESULT in return 0 }
        self.AddRef = { _ -> ULONG in return 0 }
        self.Release = { _ -> ULONG in return 0 }
        self.Initialize = { _ -> OSStatus in return 0 }
        self.CreateDevice = { _ -> OSStatus in return 0 }
        self.DestroyDevice = { _ -> OSStatus in return 0 }
        self.AddDeviceClient = { _ -> OSStatus in return 0 }
        self.RemoveDeviceClient = { _ -> OSStatus in return 0 }
        self.PerformDeviceConfigurationChange = { _ -> OSStatus in return 0 }
        self.AbortDeviceConfigurationChange = { _ -> OSStatus in return 0 }
        self.HasProperty = { _ -> DarwinBoolean in return false }
        self.IsPropertySettable = { _ -> OSStatus in return 0 }
        self.GetPropertyDataSize = { _ -> OSStatus in return 0 }
        self.GetPropertyData = { _ -> OSStatus in return 0 }
        self.SetPropertyData = { _ -> OSStatus in return 0 }
        self.StartIO = { _ -> OSStatus in return 0 }
        self.StopIO = { _ -> OSStatus in return 0 }
        self.GetZeroTimeStamp = { _ -> OSStatus in return 0 }
        self.WillDoIOOperation = { _ -> OSStatus in return 0 }
        self.BeginIOOperation = { _ -> OSStatus in return 0 }
        self.DoIOOperation = { _ -> OSStatus in return 0 }
        self.EndIOOperation = { _ -> OSStatus in return 0 }
    }

//    init(queryInterface: @escaping QueryInterfaceFunc,
//         addRef: @escaping AddRefFunc,
//         release: @escaping ReleaseFunc,
//         initialize: @escaping InitializeFunc,
//         createDevice: @escaping CreateDeviceFunc,
//         destroyDevice: @escaping DestroyDeviceFunc,
//         addDeviceClient: @escaping AddDeviceClientFunc,
//         removeDeviceClient: @escaping RemoveDeviceClientFunc,
//         performDeviceConfigurationChange: @escaping PerformDeviceConfigurationChangeFunc,
//         abortDeviceConfigurationChange: @escaping AbortDeviceConfigurationChangeFunc,
//         hasProperty: @escaping HasPropertyFunc,
//         isPropertySettable: @escaping IsPropertySettableFunc,
//         getPropertyDataSize: @escaping GetPropertyDataSizeFunc,
//         getPropertyData: @escaping GetPropertyDataFunc,
//         setPropertyData: @escaping SetPropertyDataFunc,
//         startIO: @escaping StartIOFunc,
//         stopIO: @escaping StopIOFunc,
//         getZeroTimeStamp: @escaping GetZeroTimeStampFunc,
//         willDoIOOperation: @escaping WillDoIOOperationFunc,
//         beginIOOperation: @escaping BeginIOOperationFunc,
//         doIOOperation: @escaping DoIOOperationFunc,
//         endIOOperation: @escaping EndIOOperationFunc
//        )
//    {
//        self._reserved = nil
//        self.QueryInterface = { (_ inDriver: UnsafeMutableRawPointer?, _ inUUID: REFIID, _ outInterface: UnsafeMutablePointer<LPVOID?>?) -> HRESULT in
//            queryInterface(inDriver, inUUID, outInterface)
//        }
//        self.AddRef = { (_ inDriver: UnsafeMutableRawPointer?) -> ULONG in
//            addRef(inDriver)
//        }
//        self.Release = { (_ inDriver: UnsafeMutableRawPointer?) -> ULONG in
//            release(inDriver)
//        }
//        self.Initialize = { (_ inDriver: AudioServerPlugInDriverRef, _ inHost: AudioServerPlugInHostRef) -> OSStatus in
//            initialize(inDriver, inHost)
//        }
//        self.CreateDevice = { (_ inDriver: AudioServerPlugInDriverRef, _ inDescription: CFDictionary, _ inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>, _ outDeviceObjectID: UnsafeMutablePointer<AudioObjectID>) -> OSStatus in
//            createDevice(inDriver, inDescription, inClientInfo, outDeviceObjectID)
//        }
//        self.DestroyDevice = { (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID) -> OSStatus in
//            destroyDevice(inDriver, inDeviceObjectID)
//        }
//        self.AddDeviceClient = { (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus in
//            addDeviceClient(inDriver, inDeviceObjectID, inClientInfo)
//        }
//        self.RemoveDeviceClient = { (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus in
//            removeDeviceClient(inDriver, inDeviceObjectID, inClientInfo)
//        }
//        self.PerformDeviceConfigurationChange = { (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inChangeAction: UInt64, _ inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus in
//            performDeviceConfigurationChange(inDriver, inDeviceObjectID, inChangeAction, inChangeInfo)
//        }
//        self.AbortDeviceConfigurationChange = { (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inChangeAction: UInt64, _ inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus in
//            abortDeviceConfigurationChange(inDriver, inDeviceObjectID, inChangeAction, inChangeInfo)
//        }
//        self.HasProperty = { (_ inDriver: AudioServerPlugInDriverRef, _ inObjectID: AudioObjectID, _ inClientProcessID: pid_t, _ inAddress: UnsafePointer<AudioObjectPropertyAddress>) -> DarwinBoolean in
//            hasProperty(inDriver, inObjectID, inClientProcessID, inAddress)
//        }
//        self.IsPropertySettable = { (_ inDriver: AudioServerPlugInDriverRef, _ inObjectID: AudioObjectID, _ inClientProcessID: pid_t, _ inAddress: UnsafePointer<AudioObjectPropertyAddress>, _ outIsSettable: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus in
//            isPropertySettable(inDriver, inObjectID, inClientProcessID, inAddress, outIsSettable)
//        }
//        self.GetPropertyDataSize = { (_ inDriver: AudioServerPlugInDriverRef, _ inObjectID: AudioObjectID, _ inAddress: pid_t, _ inClientProcessID: UnsafePointer<AudioObjectPropertyAddress>, _ inQualifierDataSize: UInt32, _ inQualifierData: UnsafeRawPointer?, _ outDataSize: UnsafeMutablePointer<UInt32>) -> OSStatus in
//            getPropertyDataSize(inDriver, inObjectID, inAddress, inClientProcessID, inQualifierDataSize, inQualifierData, outDataSize)
//        }
//        self.GetPropertyData = { (_ inDriver: AudioServerPlugInDriverRef, _ inObjectID: AudioObjectID, _ inClientProcessID: pid_t, _ inAddress: UnsafePointer<AudioObjectPropertyAddress>, _ inQualifierDataSize: UInt32, _ inQualifierData: UnsafeRawPointer?, _ inDataSize: UInt32, _ outDataSize: UnsafeMutablePointer<UInt32>, _ outData: UnsafeMutableRawPointer) -> OSStatus in
//            getPropertyData(inDriver, inObjectID, inClientProcessID, inAddress, inQualifierDataSize, inQualifierData, inDataSize, outDataSize, outData)
//        }
//        self.SetPropertyData = { (_ inDriver: AudioServerPlugInDriverRef, _ inObjectID: AudioObjectID, _ inClientProcessID: pid_t, _ inAddress: UnsafePointer<AudioObjectPropertyAddress>, _ inQualifierDataSize: UInt32, _ inQualifierData: UnsafeRawPointer?, _ inDataSize: UInt32, _ inData: UnsafeRawPointer) -> OSStatus in
//            setPropertyData(inDriver, inObjectID, inClientProcessID, inAddress, inQualifierDataSize, inQualifierData, inDataSize, inData)
//        }
//        self.StartIO = { (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientID: UInt32) -> OSStatus in
//            startIO(inDriver, inDeviceObjectID, inClientID)
//        }
//        self.StopIO = { (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientID: UInt32) -> OSStatus in
//            stopIO(inDriver, inDeviceObjectID, inClientID)
//        }
//        self.GetZeroTimeStamp = { (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientID: UInt32, _ outSampleTime: UnsafeMutablePointer<Float64>, _ outHostTime: UnsafeMutablePointer<UInt64>, _ outSeed: UnsafeMutablePointer<UInt64>) -> OSStatus in
//            getZeroTimeStamp(inDriver, inDeviceObjectID, inClientID, outSampleTime, outHostTime, outSeed)
//        }
//        self.WillDoIOOperation = { (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientID: UInt32, _ inOperationID: UInt32, _ outWillDo: UnsafeMutablePointer<DarwinBoolean>, _ outWillDoInPlace: UnsafeMutablePointer<DarwinBoolean>) -> OSStatus in
//            willDoIOOperation(inDriver, inDeviceObjectID, inClientID, inOperationID, outWillDo, outWillDoInPlace)
//        }
//        self.BeginIOOperation = { (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientID: UInt32, _ inOperationID: UInt32, _ inIOBufferFrameSize: UInt32, _ inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus in
//            beginIOOperation(inDriver, inDeviceObjectID, inClientID, inOperationID, inIOBufferFrameSize, inIOCycleInfo)
//        }
//        self.DoIOOperation = { (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inStreamObjectID: AudioObjectID, _ inClientID: UInt32, _ inOperationID: UInt32, _ inIOBufferFrameSize: UInt32, _ inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>, _ ioMainBuffer: UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> OSStatus in
//            doIOOperation(inDriver, inDeviceObjectID, inStreamObjectID, inClientID, inOperationID, inIOBufferFrameSize, inIOCycleInfo, ioMainBuffer, UnsafeMutableRawPointer?)
//        }
//        self.EndIOOperation = { (_ inDriver: AudioServerPlugInDriverRef, _ inDeviceObjectID: AudioObjectID, _ inClientID: UInt32, _ inOperationID: UInt32, _ inIOBufferFrameSize: UInt32, _ inIOCycleInfo: UnsafePointer<AudioServerPlugInIOCycleInfo>) -> OSStatus in
//            endIOOperation(inDriver, inDeviceObjectID, inClientID, inOperationID, inIOBufferFrameSize, inIOCycleInfo)
//        }
//    }
}
