//
//  more.swift
//  Pancake
//
//  Created by mxa on 27.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

// MARK: - Inheritance

extension Pancake {
    
    /// Finds the interface to talk to the plug-in.
    /// A AudioServerPlugIn wrapper method.
    ///
    /// - Parameters:
    ///   - driver: The CFPlugIn type to query.
    ///   - UUID: The UUID of the interface to find.
    /// - Returns: The returned interface or nil if none was found, and an error code indicating success of failure..
    func queryInterface(driver: AudioServerPlugInDriver?, UUID: CFUUID?, writeTo outInterface: PluginInterface?) -> HRESULT {
        guard let driver = driver else { return PancakeAudioHardwareError.badObject }
        guard let interface = outInterface, let UUID = UUID else {
            assertionFailure()
            return PancakeAudioHardwareError.illegalOperation
        }
        
        guard UUID == kUUID.IUnknown || UUID == kUUID.audioServerPlugInDriverInterface else {
            assertionFailure()
            return HRESULT.noInterface
        }
        
        guard !self.pluginReferenceCounter.maxxedOut else {
            assertionFailure()
            return HRESULT.noInterface
        }
        
        self.pluginReferenceCounter.increment()
        interface.setInterfacePointer(from: driver)

        return HRESULT.ok
    }
    
    
    /// Increments the reference count and returns it.
    ///
    /// - Parameter driver: The driver the call is for.
    /// - Returns: The reference count after the increment.
    func addRef(driver: AudioServerPlugInDriver?) -> UInt32 {
        guard valid(driver) else { return 0 }
        self.pluginReferenceCounter.increment()
        return self.pluginReferenceCounter.value
    }
    
    
    /// Decrements the reference count and returns it.
    ///
    /// - Parameter driver: The driver the call is for.
    /// - Returns: The reference count after the decrement.
    func release(driver: AudioServerPlugInDriver?) -> UInt32 {
        guard valid(driver) else { return 0 }
        self.pluginReferenceCounter.decrement()
        return self.pluginReferenceCounter.value
    }
}
