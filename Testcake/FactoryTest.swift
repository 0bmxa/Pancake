//
//  PluginLoadingTest.swift
//  Testcake
//
//  Created by mxa on 02.12.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn
import XCTest

let kAudioServerPlugInTypeUUID = CFUUIDCreateFromString(nil, "443ABAB8-E7B3-491A-B985-BEB9187030DB" as CFString)!

class FactoryTest: XCTestCase {

    func testPluginFoo() {
        let pluginPointer = PancakeFactory.create(allocator: nil, requestedTypeUUID: kAudioServerPlugInTypeUUID)
        XCTAssertNotNil(pluginPointer)

//        let driverRef = AudioServerPlugInDriverRef(pluginPointer!)
//        XCTAssertNotNil(driverRef)
    }

    func testOnlyAudioServerPluginsAreCreated() {
        let invalidUUID = CFUUIDCreateFromString(nil, "1234" as CFString)
        let pluginPointer = PancakeFactory.create(allocator: nil, requestedTypeUUID: invalidUUID)
        XCTAssertNil(pluginPointer)
    }

}
