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
    internal var host: AudioServerPlugInHost? = nil
    internal var pluginReferenceCounter = AtomicCounter<UInt32>()
    internal var configuration: PancakeConfiguration

    /// The list of all audio objects
    internal let audioObjects = PancakeAudioObjectList()
    internal let customProperties = [AudioServerPlugInCustomPropertyInfo]()

    init(driverReference: AudioServerPlugInDriverRef?, configuration: PancakeConfiguration) {
        self.driver = AudioServerPlugInDriver(from: driverReference)!
        self.configuration = configuration

        // Setup the audio objects list
        self.audioObjects.initialize(pancake: self)
    }
    
    internal func setup() {
//        // Get some params from a storage
//        self.configuration.box.acquired = host?.copyFromStorage(key: "box aquired").data as? Bool   ?? false
//        self.configuration.box.name     = host?.copyFromStorage(key: "box name").data as? String ?? "Pancake Box"

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
        let device = PancakeDevice(pancake: self)
        let inputStream  = PancakeStream(pancake: self)  // TODO: assign inputness
        let outputStream = PancakeStream(pancake: self)  // TODO: assign outputness
        self.audioObjects.add(object: device)
        self.audioObjects.add(object: inputStream)
        self.audioObjects.add(object: outputStream)
        device.streams = [inputStream, outputStream]

        // Host ticks per frame
        self.configuration.activeSampleRate = 44100
    }
    

    
    // Shared instance
    private static var _shared: Pancake?
    static var shared: Pancake {
        guard let shared = Pancake._shared else {
            fatalError("The shared instance was never set up. Please call `Pancake.setupSharedInstance()` first before accessing it.")
        }
        return shared
    }
    static func setupSharedInstance(driverReference: AudioServerPlugInDriverRef?, configuration: PancakeConfiguration) {
        guard _shared == nil else { fatalError("The shared instance has already been set up.") }
        Pancake._shared = Pancake(driverReference: driverReference, configuration: configuration)
    }
}


struct PancakeConfiguration {
    /// The plugin vendor.
    var manufacturer: String
    
    /// The plugin name.
    var productName: String
    
    /// The audio formats the plugin supports.
    var supportedFormats: [AudioStreamBasicDescription]
    
    
    var activeSampleRate: Float
    
    var ticksPerFrame: Double {
        let ticksPerSecond = MachTimebaseInfo().ticksPerSecond
        return ticksPerSecond / Double(self.activeSampleRate)
    }
    
    var descriptions: [AudioStreamRangedDescription] {
        return self.supportedFormats.map { AudioStreamRangedDescription(asbd: $0) }
    }
}

