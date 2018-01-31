//
//  Factory.swift
//  Pancake
//
//  Created by mxa on 20.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn
import Foundation
import Pancake


/// Wrapper around the create() func, to allow exposing to (Obj)C.
@objc
class PancakeFactory: NSObject {
    //swiftlint:disable implicitly_unwrapped_optional
    @objc
    static func create(allocator: CFAllocator!, requestedTypeUUID: CFUUID!) -> UnsafeMutableRawPointer? {
    //swiftlint:enable implicitly_unwrapped_optional

        guard UUID(rawValue: requestedTypeUUID) == kUUID.audioServerPlugInTypeUUID else { return nil }

        // Pancake configuration
        let device = Pancake.DeviceConfiguration(
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
        let config = Pancake.Configuration(devices: [device])


        // Option 2: Setup with processing
        /*
        let signalProcessorSetup: () -> Void = {
            // Setup your signal processor here
        }
        let processingCallback = { (buffer: UnsafeMutableBufferPointer<Float32>, cycle: AudioServerPlugInIOCycleInfo) in
            // Do your audio processing here
        }
        device.processingCallback = processingCallback
        let config = Configuration(devices: [device], signalProcessorSetup: signalProcessorSetup)
        */


        // Configure the shared Pancake plugin instance
        Pancake.setupSharedInstance(configuration: config)

        return UnsafeMutableRawPointer(Pancake.driverReference)
    }
}
