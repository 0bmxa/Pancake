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
    internal var configuration: Configuration

    /// The list of all audio objects
    internal let audioObjects = PancakeAudioObjectList()
    internal let customProperties = [AudioServerPlugInCustomPropertyInfo]()

    init(driverReference: AudioServerPlugInDriverRef?, configuration: Configuration = Configuration.default) {
        self.driver = AudioServerPlugInDriver(from: driverReference)!
        self.configuration = configuration
        
        // Setup the audio objects list
        self.audioObjects.initialize(pancake: self)
    }

    
    // Shared instance
    private static var _shared: Pancake?
    static var shared: Pancake {
        guard let shared = Pancake._shared else {
            fatalError("The shared instance was never set up. Please call `Pancake.setupSharedInstance()` first before accessing it.")
        }
        return shared
    }
    static func setupSharedInstance(driverReference: AudioServerPlugInDriverRef?) {
        Pancake._shared = Pancake(driverReference: driverReference)
    }
}


struct Configuration {
    var manufacturer: String
    var productName: String
    var sampleRate: Float
    var ticksPerFrame: Double
    
    static let `default` = Configuration(
        manufacturer: "Pancake Manufacturer",
        productName: "Pancake Framework",
        sampleRate: 44100.0,
        ticksPerFrame: 0
    )
    
//    struct Box {
//        var name: String
//        var acquired: Bool
//        
//        static let `default` = Box(name: "Pancake Box", acquired: false)
//    }
}


