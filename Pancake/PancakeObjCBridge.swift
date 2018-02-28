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

        // Convert to device configs
        let devices = cDevices.flatMap { device in
            DeviceConfiguration(from: device)
        }

        // Create pancake config struct
        let setupCallback = config.pointee.setupCallback
        let configuration = Configuration(devices: devices, pluginSetupCallback: setupCallback)

        // Setup pancake
        Pancake.setupSharedInstance(configuration: configuration)
    }

    @objc public static
    var driverInterface: UnsafeMutableRawPointer {
        return UnsafeMutableRawPointer(Pancake.driverReference)
    }
}



extension DeviceConfiguration {
    /// Initializes a DeviceConfiguration object from a C PancakeDeviceConfiguration struct.
    /// This copies all values and therefore does not influence ownership of the original struct.
    convenience init?(from config: UnsafeMutablePointer<PancakeDeviceConfiguration>?) {
        guard let config = config?.pointee else { return nil }

        var manufacturer: String? = nil
        if let _manufacturer = config.manufacturer?.takeUnretainedValue() {
            manufacturer = String(_manufacturer)
        }
        let name    = String(config.name.takeUnretainedValue())
        let UID     = String(config.UID.takeUnretainedValue())
        let formats = Array(UnsafeMutableBufferPointer(start: config.supportedFormats, count: Int(config.numberOfSupportedFormats)))

        self.init(manufacturer: manufacturer, name: name, UID: UID, supportedFormats: formats)

        self.processingCallback = config.processingCallback
        self.startIOCallback    = config.startIO
        self.stopIOCallback     = config.stopIO
    }
}
