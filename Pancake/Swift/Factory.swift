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

internal class Pancake {
    
    static let driverInterface = AudioServerPlugInDriverInterface(
        queryInterface: queryInterface,
        addRef: addRef,
        release: release,
        initialize: initialize,
        createDevice: createDevice,
        destroyDevice: destroyDevice,
        addDeviceClient: addDeviceClient,
        removeDeviceClient: removeDeviceClient,
        performDeviceConfigurationChange: performDeviceConfigurationChange,
        abortDeviceConfigurationChange: abortDeviceConfigurationChange,
        hasProperty: hasProperty,
        isPropertySettable: isPropertySettable,
        getPropertyDataSize: getPropertyDataSize,
        getPropertyData: getPropertyData,
        setPropertyData: setPropertyData,
        startIO: startIO,
        stopIO: stopIO,
        getZeroTimeStamp: getZeroTimeStamp,
        willDoIOOperation: willDoIOOperation,
        beginIOOperation: beginIOOperation,
        doIOOperation: doIOOperation,
        endIOOperation: endIOOperation
    )
    
//    static func create(allocator: CFAllocator?, requestedTypeUUID: CFUUID?) -> UnsafeMutableRawPointer? {
////    static func create(allocator: CFAllocator?, requestedTypeUUID: CFUUID?) -> AudioServerPlugInDriverRef? {
//        guard CFEqual(requestedTypeUUID, kAudioServerPlugInTypeUUID) else {
//            return nil
//        }
//        
//        
////        var foo = Foo()
////        _ = oop(fobo: &foo)
//        
////        AudioServerPlugInDriverRef(from: <#T##UnsafeMutablePointer<AudioServerPlugInDriverInterface>#>)
//
//        
////        let driverReference = AudioServerPlugInDriver.reference(from: &driverInterface)
////        let driverReference = AudioServerPlugInDriverRef(from: &driverInterface)
////        let driverReference: AudioServerPlugInDriverRef? = nil
//  
//        
//        var driverReference1: UnsafeMutablePointer<AudioServerPlugInDriverInterface>? = makeUnsafeMutablePointer(&driverInterface)
////        let driverReference2 = makeUnsafeMutablePointer(&driverReference1)
////        driverReference = driverReference1
//        
////        var driverInterfacePointer = withUnsafeMutablePointer(to: &driverInterface) { return $0 }
////        let driverReference: AudioServerPlugInDriverRef = withUnsafeMutablePointer(to: &driverInterfacePointer) { return $0 }
//        
//        let foo = UnsafeMutableRawPointer.init(driverReference1)
//        return foo
////        return driverReference1
//    }
    
}


//func makeUnsafeMutablePointer<T>(_ pointer: UnsafeMutablePointer<T>) -> UnsafeMutablePointer<T> {
//    return pointer
//}
