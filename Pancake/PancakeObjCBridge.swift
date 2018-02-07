//
//  PancakeObjCBridge.swift
//  Pancake
//
//  Created by mxa on 19.12.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import Foundation

@objc(Pancake) public
class PancakeObjCBridge: NSObject {
    override init() {}

    @objc public
    class func setupSharedInstance(_ config: UnsafePointer<PancakeConfiguration>) {
        guard
            config.pointee.numberOfDevices != 0,
            config.pointee.devices != nil
        else { return }

        // Translate memory to a buffer pointer
        let cDevices = UnsafeMutableBufferPointer(start: config.pointee.devices, count: Int(config.pointee.numberOfDevices))

        Array(cDevices).forEach { device in
            print(device)
        }

        // Convert to device configs
        let devices = cDevices.map { device -> DeviceConfiguration in
            print(device)
            let foo = DeviceConfiguration(from: device)
            print(foo)
            return foo
        }

        // Create pancake config struct & setup pancake
        let config = Configuration(devices: devices)
        Pancake.setupSharedInstance(configuration: config)
    }

    @objc public static
    var driverInterface: UnsafeMutableRawPointer {
        return UnsafeMutableRawPointer(Pancake.driverReference)
    }
}



extension DeviceConfiguration {
    convenience init(from config: PancakeDeviceConfiguration) {
        var manufacturer: String? = nil
        if let man = config.manufacturer?.takeUnretainedValue() {
            manufacturer = String(man)
        }
        let name         = String(config.name.takeUnretainedValue())
        let UID          = String(config.UID.takeUnretainedValue())
        let formats      = Array(UnsafeMutableBufferPointer(start: config.supportedFormats, count: Int(config.numberOfSupportedFormats)))

        self.init(manufacturer: manufacturer, name: name, UID: UID, supportedFormats: formats)
    }
}
