//
//  Pancake.swift
//  Pancake
//
//  Created by mxa on 20.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

public class Pancake {
    internal let driver: AudioServerPlugInDriver
    internal var host: AudioServerPlugInHost?
    internal var pluginReferenceCounter = AtomicCounter<UInt32>()
    internal var configuration: PancakeInternalConfiguration

    /// The list of all audio objects
    internal let audioObjects = PancakeAudioObjectList()

    /// A (possible) list of custom properties the HAL doesn't provide
    internal let customProperties = [AudioServerPlugInCustomPropertyInfo]()

    init(configuration: Configuration) {
        self.driver = AudioServerPlugInDriver(from: Pancake.driverReference)
        self.configuration = PancakeInternalConfiguration(from: configuration)

        // Initialize the audio objects list
        self.audioObjects.initialize(pancake: self)
    }

    // Shared instance
    private static var _shared: Pancake?
    public static var shared: Pancake {
        guard let shared = Pancake._shared else {
            fatalError("The shared instance was never set up. Please call `Pancake.setupSharedInstance()` first before accessing it.")
        }
        return shared
    }
    public static func setupSharedInstance(configuration: Configuration) {
        guard _shared == nil else { fatalError("The shared instance has already been set up.") }
        Pancake._shared = Pancake(configuration: configuration)
    }
}

extension Pancake {
    /// Creates a basic setup, based on the user config, consisting of
    /// - 1 box
    /// - 1 device
    ///   - 1 input stream
    ///   - 1 output stream
    internal func setup() {
        // Create a box. As we only always have one (which should never be
        // user facing), we can configure it statically here.
        let box = PancakeBox(pancake: self, UID: "PancakeBox", name: "Pancake Box")
        self.audioObjects.add(object: box)

        // Only the first device is created atm.
        let deviceConfig = self.configuration.devices[0]

        // Create a device with 2 streams
        let device = PancakeDevice(pancake: self, configuration: deviceConfig)
        self.audioObjects.add(device)

        let channelCount = deviceConfig.registeredFormat.mBitsPerChannel
        let inputStream  = PancakeStream(pancake: self, direction: .input,  channelCount: channelCount)
        let outputStream = PancakeStream(pancake: self, direction: .output, channelCount: channelCount)
        self.audioObjects.add(inputStream, outputStream)

        device.setStreams([inputStream, outputStream])
    }

}
