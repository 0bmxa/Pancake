//
//  Factory.swift
//  Pancake
//
//  Created by mxa on 20.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import Foundation
import CoreAudio.AudioServerPlugIn


// MARK: - Framework

var pancake = Pancake()

func Pancake_Create(allocator: CFAllocator!, requestedTypeUUID: CFUUID!) -> UnsafeMutableRawPointer? {
    let driverRef = pancake.create(allocator: allocator, requestedTypeUUID: requestedTypeUUID)
    return UnsafeMutableRawPointer(driverRef)
}


internal class Pancake {
    
    static var driverInterface: AudioServerPlugInDriverInterface? = nil
    static var driverReference: AudioServerPlugInDriverRef? = nil
    
    func create(allocator: CFAllocator?, requestedTypeUUID: CFUUID?) -> AudioServerPlugInDriverRef? {
        guard CFEqual(requestedTypeUUID, kAudioServerPlugInTypeUUID) else {
            return nil
        }
        
        let driverInterface = AudioServerPlugInDriverInterface(
            queryInterface: Pancake_queryInterface,
            addRef: Pancake_addRef,
            release: Pancake_release,
            initialize: Pancake_initialize,
            createDevice: Pancake_createDevice,
            destroyDevice: Pancake_destroyDevice,
            addDeviceClient: Pancake_addDeviceClient,
            removeDeviceClient: Pancake_removeDeviceClient,
            performDeviceConfigurationChange: Pancake_performDeviceConfigurationChange,
            abortDeviceConfigurationChange: Pancake_abortDeviceConfigurationChange,
            hasProperty: Pancake_hasProperty,
            isPropertySettable: Pancake_isPropertySettable,
            getPropertyDataSize: Pancake_getPropertyDataSize,
            getPropertyData: Pancake_getPropertyData,
            setPropertyData: Pancake_setPropertyData,
            startIO: Pancake_startIO,
            stopIO: Pancake_stopIO,
            getZeroTimeStamp: Pancake_getZeroTimeStamp,
            willDoIOOperation: Pancake_willDoIOOperation,
            beginIOOperation: Pancake_beginIOOperation,
            doIOOperation: Pancake_doIOOperation,
            endIOOperation: Pancake_endIOOperation
        )
        let driverReference = driverReferenceFromInterface(driverInterface)
        
        Pancake.driverInterface = driverInterface
        Pancake.driverReference = driverReference
        
        return driverReference
    }

}

