//
//  PlugInTest.swift
//  Testcake
//
//  Created by mxa on 06.12.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import XCTest

let pluginURL = URL(string: "/Library/Audio/Plug-Ins/HAL/SampleDriver.driver")!
let kAudioServerPlugInTypeUUID = CFUUIDCreateFromString(nil, "443ABAB8-E7B3-491A-B985-BEB9187030DB" as CFString)!

class PlugInTest: XCTestCase {
    func testPluginExists() {
        let plugin = CFPlugInCreate(nil, pluginURL as CFURL)
        XCTAssertNotNil(plugin)
    }

    func testAudioServerPlugInFactoryExists() {
        let plugin = CFPlugInCreate(nil, pluginURL as CFURL)
        let factoryUUIDs = CFPlugInFindFactoriesForPlugInTypeInPlugIn(kAudioServerPlugInTypeUUID, plugin) as? [CFUUID]
        XCTAssertNotNil(factoryUUIDs)
        XCTAssertEqual(factoryUUIDs?.count, 1)
    }
}
