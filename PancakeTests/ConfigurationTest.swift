//
//  ConfigurationTest.swift
//  Testcake
//
//  Created by mxa on 06.12.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.CoreAudioTypes
import XCTest

class ConfigurationTest: XCTestCase {

    func testConfigurationIsReadCorrectly() {

        let pancake: Pancake = {
            let device = DeviceConfiguration(
                manufacturer: "Test Manufacturer",
                name: "Test Name",
                UID: "Test UID",
                supportedFormats: [
                    AudioStreamBasicDescription(sampleRate: 44100, channelCount: 2, format: .float32),
                    AudioStreamBasicDescription(sampleRate: 48000, channelCount: 2, format: .float32),
                    AudioStreamBasicDescription(sampleRate: 96000, channelCount: 2, format: .float32)
                ]
            )
            let config = Configuration(devices: [device])
            let mockDriverReference = AudioServerPlugInDriverRef.allocate(capacity: 1)
            let pancake = Pancake(driverReference: mockDriverReference, configuration: config)
            pancake.setup()
            return pancake
        }()

        XCTAssertEqual(pancake.audioObjects.IDsForObjects(of: PancakePlugin.self).count, 1)
        XCTAssertEqual(pancake.audioObjects.IDsForObjects(of: PancakeBox.self).count, 1)
        XCTAssertEqual(pancake.audioObjects.IDsForObjects(of: PancakeDevice.self).count, 1)
        XCTAssertEqual(pancake.audioObjects.IDsForObjects(of: PancakeStream.self).count, 2)
        XCTAssertEqual(pancake.audioObjects.IDsForObjects(of: PancakeControl.self).count, 2)

        let device = pancake.configuration.devices.first
        XCTAssertNotNil(device)
        XCTAssertEqual(device?.manufacturer, "Test Manufacturer")
        XCTAssertEqual(device?.name, "Test Name")
        XCTAssertEqual(device?.UID, "Test UID")
        XCTAssertEqual(device?.supportedFormats.count, 3)
        XCTAssertEqual(device?.registeredFormat.mSampleRate, device?.supportedFormats.first?.mSampleRate)

    }

}
