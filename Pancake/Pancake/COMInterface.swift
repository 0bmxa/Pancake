//
//  more.swift
//  Pancake
//
//  Created by mxa on 27.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

extension Pancake {

    /// Finds the plugin's interface.
    /// From the IUnknown interface standard.
    ///
    /// - Parameters:
    ///   - driver: The CFPlugIn type to query.
    ///   - UUID: The UUID of the interface to find.
    /// - Returns: The returned interface or nil if none was found, and an error code indicating success of failure..
    func queryInterface(UUID: UUID, writeTo outInterface: PluginInterface?) -> HRESULT {
        guard let interface = outInterface else {
            assertionFailure()
            return PancakeAudioHardwareError.illegalOperation
        }

        guard
            UUID == kUUID.IUnknown || UUID == kUUID.audioServerPlugInDriverInterface,
            !self.pluginReferenceCounter.maxxedOut
        else {
            assertionFailure()
            return HRESULT.noInterface
        }

        self.pluginReferenceCounter.increment()
        interface.setInterfacePointer(from: self.driver)

        return HRESULT.ok
    }


    /// Increments the reference count and returns it.
    /// From the IUnknown interface standard.
    ///
    /// - Parameter driver: The driver the call is for.
    /// - Returns: The reference count after the increment.
    func addRef() -> UInt32 {
        self.pluginReferenceCounter.increment()
        return self.pluginReferenceCounter.value
    }


    /// Decrements the reference count and returns it.
    /// From the IUnknown interface standard.
    ///
    /// - Parameter driver: The driver the call is for.
    /// - Returns: The reference count after the decrement.
    func release() -> UInt32 {
        self.pluginReferenceCounter.decrement()
        return self.pluginReferenceCounter.value
    }
}
