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

        // Create one device
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

        device.processingCallback = renderCallback
        device.startIOCallback = startIOCycle
        device.stopIOCallback = stopIOCycle


        // Create a configuration object
        let config = Configuration(devices: [device], pluginSetupCallback: setupCallback)

        // Configure the shared Pancake plugin instance
        Pancake.setupSharedInstance(configuration: config)

        return UnsafeMutableRawPointer(Pancake.driverReference)
    }
}

func setupCallback() {
    // The plugin is being instantiated. Do your general setup here.
}

func startIOCycle(sampleRate: Double, frameCount: UInt32) {
    // A render cycle is about to begin. Prepare yourself for being ready to render.
}

func renderCallback(samples: UnsafeMutablePointer<Float32>, frameCount: UInt32, channelCount: UInt32, cycleInfo: AudioServerPlugInIOCycleInfo) {
    // A render cycle is happening right now.
}

func stopIOCycle(sampleRate: Double, frameCount: UInt32) {
    // The render cycle just completed.
}
