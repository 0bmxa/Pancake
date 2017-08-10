//
//  PancakeBridge.swift
//  Pancake
//
//  Created by mxa on 26.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import Foundation
import CoreAudio.AudioServerPlugIn

@objc public class PancakeBridge: NSObject {
    public static let queryInterfaceFunc = pancake.queryInterface
    public static let addRefFunc = Pancake.addRef
    public static let releaseyyyFunc = Pancake.release
    public static let initializeyyyFunc = Pancake.initialize
    public static let createDeviceFunc = Pancake.createDevice
    public static let destroyDeviceFunc = Pancake.destroyDevice
    public static let addDeviceClientFunc = Pancake.addDeviceClient
    public static let removeDeviceClientFunc = Pancake.removeDeviceClient
    public static let performDeviceConfigurationChangeFunc = Pancake.performDeviceConfigurationChange
    public static let abortDeviceConfigurationChangeFunc = Pancake.abortDeviceConfigurationChange
    public static let hasPropertyFunc = Pancake.hasProperty
    public static let isPropertySettableFunc = Pancake.isPropertySettable
    public static let getPropertyDataSizeFunc = Pancake.getPropertyDataSize
    public static let getPropertyDataFunc = Pancake.getPropertyData
    public static let setPropertyDataFunc = Pancake.setPropertyData
    public static let startIOFunc = Pancake.startIO
    public static let stopIOFunc = Pancake.stopIO
    public static let getZeroTimeStampFunc = Pancake.getZeroTimeStamp
    public static let willDoIOOperationFunc = Pancake.willDoIOOperation
    public static let beginIOOperationFunc = Pancake.beginIOOperation
    public static let doIOOperationFunc = Pancake.doIOOperation
    public static let endIOOperationFunc = Pancake.endIOOperation
    
    private static let pancake = Pancake()
    
    public static var driver: UnsafeMutablePointer<AudioServerPlugInDriverInterface>? {
        didSet {
            Pancake.setDriverInterface(interfacePointer: &(PancakeBridge.driver))
        }
    }
}
