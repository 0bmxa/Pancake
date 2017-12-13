//
//  PluginLoadingTest.swift
//  Testcake
//
//  Created by mxa on 02.12.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import XCTest
@testable import SampleDriver

class FactoryTest: XCTestCase {
    func testPluginIsCreated() {
        let pluginPointer = PancakeFactory.create(allocator: nil, requestedTypeUUID: kAudioServerPlugInTypeUUID)
        XCTAssertNotNil(pluginPointer)
    }

    func testOnlyAudioServerPluginsAreCreated() {
        let invalidUUID = CFUUIDCreateFromString(nil, "1234" as CFString)
        let pluginPointer = PancakeFactory.create(allocator: nil, requestedTypeUUID: invalidUUID)
        XCTAssertNil(pluginPointer)
    }
}
