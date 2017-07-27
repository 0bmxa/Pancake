//
//  FactoryBridge.swift
//  Pancake
//
//  Created by mxa on 26.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import Foundation

@objc public class PancakeFactory: NSObject {
//    @objc public static let factory: CFPlugInFactoryFunction = { (allocator, requestedTypeUUID) -> UnsafeMutableRawPointer? in
//        let driverReference = Pancake.create(allocator: allocator, requestedTypeUUID: requestedTypeUUID)
//        return UnsafeMutableRawPointer(driverReference)
//    }
    
    @objc public static let driverInterface = Pancake.driverInterface
}
