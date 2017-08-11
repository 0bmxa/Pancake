//
//  more.swift
//  Pancake
//
//  Created by mxa on 27.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

//struct Result<E, R> {
//    let errorCode: E
//    let result: R
//}

struct AtomicCounter {
    private var value: UInt = 0
    private let serialQueue = DispatchQueue(label: "")
    
    mutating func increment() {
        self.serialQueue.sync {
            self.value += 1
        }
    }

    mutating func decrement() {
        self.serialQueue.sync {
            self.value -= 1
        }
    }
}


class PancakeInheritance {
    
    private let driverReference: AudioServerPlugInDriver
    private var pluginReferencesCounter = AtomicCounter()
    
    init(driverReference: AudioServerPlugInDriver) {
        self.driverReference = driverReference
    }

    /// Finds the interface to talk to the plug-in.
    /// A AudioServerPlugIn wrapper method.
    ///
    /// - Parameters:
    ///   - driver: The CFPlugIn type to query.
    ///   - UUID: The UUID of the interface to find.
    /// - Returns: The returned interface or nil if none was found, and an error code indicating success of failure..
    func queryInterface(driver: AudioServerPlugInDriver?, UUID: CFUUID?, writeTo outInterface: PluginInterface?) -> HRESULT {
        
        guard let driver = driver else {
            assertionFailure()
            return kAudioHardwareBadObjectError
        }
        
        guard driver == self.driverReference else {
            assertionFailure()
            return kAudioHardwareBadObjectError
        }
        
        guard let interface = outInterface, let UUID = UUID else {
            assertionFailure()
            return kAudioHardwareIllegalOperationError
        }
        
        guard UUID == kUUID.IUnknown || UUID == kUUID.audioServerPlugInDriverInterface else {
            assertionFailure()
            return HRESULT.noInterface
        }
        
        self.pluginReferencesCounter.increment()
        interface.setInterfacePointer(from: driver)
    
        return HRESULT.ok
    }
    
    func addRef(driver: AudioServerPlugInDriverRef?) -> ULONG {
        return 0
    }
    
    func release(driver: AudioServerPlugInDriverRef?) -> ULONG {
        return 0
    }
}

