//
//  Pancake.swift
//  Pancake
//
//  Created by mxa on 20.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

internal class Pancake {
    internal let driver: AudioServerPlugInDriver
    internal var host: AudioServerPlugInHost?
    internal var pluginReferenceCounter = AtomicCounter<UInt32>()
    internal var configuration: PancakeInternalConfiguration

    /// The list of all audio objects
    internal let audioObjects = PancakeAudioObjectList()

    /// A (possible) list of custom properties the HAL doesn't provide
    internal let customProperties = [AudioServerPlugInCustomPropertyInfo]()

    public init(driverReference: AudioServerPlugInDriverRef?, configuration: Configuration) {
        self.driver = AudioServerPlugInDriver(from: driverReference)!
        self.configuration = PancakeInternalConfiguration(devices: configuration.devices)

        // Initialize the audio objects list
        self.audioObjects.initialize(pancake: self)
    }

    internal func setup() {
//        // Get some params from a storage
//        self.configuration.box.acquired = host?.copyFromStorage(key: "box aquired").data as? Bool   ?? false
//        self.configuration.box.name     = host?.copyFromStorage(key: "box name").data as? String ?? "Pancake Box"

        // TODO: Load from user config or storage

        let setupLoadedFromDisk = false
        if !setupLoadedFromDisk {
            self.createBasicSetup()
        }
    }

    /// Creates a basic audio setup, consisting of
    /// - 1 box
    /// - 1 device
    //    - 1 input stream
    //    - 1 output stream
    private func createBasicSetup() {
        // Add some initial audio objects
        self.audioObjects.add(object: PancakeBox(pancake: self))

        // Create a device with 2 streams
        let inputStream  = PancakeStream(pancake: self, direction: .input,  channelCount: 2)
        let outputStream = PancakeStream(pancake: self, direction: .output, channelCount: 2)

        // FIXME: Only the first device is created atm.
        let deviceConfig = self.configuration.devices[0]
        let device = PancakeDevice(pancake: self, streams: [inputStream, outputStream], configuration: deviceConfig)

        self.audioObjects.add(device, inputStream, outputStream)
    }



    // Shared instance
    private static var _shared: Pancake?
    static var shared: Pancake {
        guard let shared = Pancake._shared else {
            fatalError("The shared instance was never set up. Please call `Pancake.setupSharedInstance()` first before accessing it.")
        }
        return shared
    }
    static func setupSharedInstance(driverReference: AudioServerPlugInDriverRef?, configuration: Configuration) {
        guard _shared == nil else { fatalError("The shared instance has already been set up.") }
        Pancake._shared = Pancake(driverReference: driverReference, configuration: configuration)
    }
}
