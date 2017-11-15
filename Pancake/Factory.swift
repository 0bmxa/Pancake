//
//  Factory.swift
//  Pancake
//
//  Created by mxa on 20.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import Foundation
import CoreAudio.AudioServerPlugIn


/// The global driver interface
var pancakeDriverInterface: AudioServerPlugInDriverInterface?
var pancakeDriverInterfacePointer: UnsafeMutablePointer<AudioServerPlugInDriverInterface>?
var pancakeDriverReference: AudioServerPlugInDriverRef?


/// Wrapper around the create() func, to allow exposing to (Obj)C.
@objc class PancakeFactory: NSObject {
    @objc static func create(allocator: CFAllocator!, requestedTypeUUID: CFUUID!) -> UnsafeMutableRawPointer? {

        guard UUID(rawValue: requestedTypeUUID) == kUUID.audioServerPlugInTypeUUID else {
            assertionFailure()
            return nil
        }

        // The driver interface, exposing all driver functions to the plugin host.
        pancakeDriverInterface = AudioServerPlugInDriverInterface(
            _reserved:                        nil,
            QueryInterface:                   Pancake_queryInterface,
            AddRef:                           Pancake_addRef,
            Release:                          Pancake_release,
            Initialize:                       Pancake_initialize,
            CreateDevice:                     Pancake_createDevice,
            DestroyDevice:                    Pancake_destroyDevice,
            AddDeviceClient:                  Pancake_addDeviceClient,
            RemoveDeviceClient:               Pancake_removeDeviceClient,
            PerformDeviceConfigurationChange: Pancake_performDeviceConfigurationChange,
            AbortDeviceConfigurationChange:   Pancake_abortDeviceConfigurationChange,
            HasProperty:                      Pancake_hasProperty,
            IsPropertySettable:               Pancake_isPropertySettable,
            GetPropertyDataSize:              Pancake_getPropertyDataSize,
            GetPropertyData:                  Pancake_getPropertyData,
            SetPropertyData:                  Pancake_setPropertyData,
            StartIO:                          Pancake_startIO,
            StopIO:                           Pancake_stopIO,
            GetZeroTimeStamp:                 Pancake_getZeroTimeStamp,
            WillDoIOOperation:                Pancake_willDoIOOperation,
            BeginIOOperation:                 Pancake_beginIOOperation,
            DoIOOperation:                    Pancake_doIOOperation,
            EndIOOperation:                   Pancake_endIOOperation
        )
        pancakeDriverInterfacePointer = withUnsafeMutablePointer(to: &pancakeDriverInterface!)       { return $0 }
        pancakeDriverReference        = withUnsafeMutablePointer(to: &pancakeDriverInterfacePointer) { return $0 }

        // Pancake configuration
        let device = DeviceConfiguration(
            manufacturer: "Pancake Manufacturer",
            name: "Pancake Framework",
            UID: "PancakeDevice",
            supportedFormats: [
                AudioStreamBasicDescription(sampleRate: 44100, channelCount: 2, format: .float32),
                AudioStreamBasicDescription(sampleRate: 48000, channelCount: 2, format: .float32),
                AudioStreamBasicDescription(sampleRate: 96000, channelCount: 2, format: .float32)
            ]
        )

        // Option 1: Setup w/o processing (loopback only)
        let config = Configuration(devices: [device])


        // Option 2: Setup with processing
        /*
        let signalProcessorSetup: () -> Void = {
            // Setup your signal processor here
        }
        let processingCallback = { (buffer: UnsafeMutableRawPointer, frameCount: Int, cycle: AudioServerPlugInIOCycleInfo) in
            // Do your audio processing here
        }
        device.processingCallback = processingCallback
        let config = Configuration(devices: [device], signalProcessorSetup: signalProcessorSetup)
        */


        // Configure the shared Pancake plugin instance
        Pancake.setupSharedInstance(driverReference: pancakeDriverReference, configuration: config)

        return UnsafeMutableRawPointer(pancakeDriverReference)
    }
}
