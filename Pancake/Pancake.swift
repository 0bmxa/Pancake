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

    internal let plugin: Plugin
    internal let device: Device
    
    init(driverReference: AudioServerPlugInDriverRef?, configuration: Configuration = Configuration.default) {
        self.driver = AudioServerPlugInDriver(from: driverReference)!
        self.configuration = configuration
        
        self.plugin = Plugin(devices: [PancakeObjectID.device])
        self.device = Device()
    }

    
    // Shared instance
    private static var _shared: Pancake?
    static var shared: Pancake {
        guard let shared = Pancake._shared else {
            fatalError("The shared instance was never set uo. Please call `Pancake.setupSharedInstance()` first before accessing it.")
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
    var box: Configuration.Box
    
    static let `default` = Configuration(
        manufacturer: "Pancake Manufacturer",
        productName: "Pancake Framework",
        sampleRate: 44100.0,
        ticksPerFrame: 0,
        box: Box.default
    )
    
    struct Box {
        var name: String
        var acquired: Bool
        
        static let `default` = Box(name: "Pancake Box", acquired: false)
    }
}



struct Plugin {
    internal var devices = [PancakeObjectID]()
}

struct Device {
}
