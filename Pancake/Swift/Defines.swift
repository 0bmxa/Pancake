//
//  Defines.swift
//  Pancake
//
//  Created by mxa on 10.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import Foundation


// MARK: - From CFPluginCOM.h

struct kUUID {
    /// The IUnknown interface
    static let IUnknown = CFUUIDGetConstantUUIDWithBytes(
        kCFAllocatorSystemDefault,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46
    )
}


// MARK: - From AudioServerPlugIn.h

extension kUUID {
    /// The UUID of the driver interface (EEA5773D-CC43-49F1-8E00-8F96E7D23B17).
    static let audioServerPlugInDriverInterface = CFUUIDGetConstantUUIDWithBytes(
        nil,
        0xEE, 0xA5, 0x77, 0x3D, 0xCC, 0x43, 0x49, 0xF1,
        0x8E, 0x00, 0x8F, 0x96, 0xE7, 0xD2, 0x3B, 0x17
    )
}


// MARK: - From CFPluginCOM.h

extension HRESULT {
    // Success
    static let ok = HRESULT(bitPattern: 0x00000000)
    static let `false` = HRESULT(bitPattern: 0x00000001)
    
    // Error
    static let unexpected = HRESULT(bitPattern: 0x8000FFFF)
    static let notImplemented = HRESULT(bitPattern: 0x80000001)
    static let outOfMemory = HRESULT(bitPattern: 0x80000002)
    static let invalidArguments = HRESULT(bitPattern: 0x80000003)
    static let noInterface = HRESULT(bitPattern: 0x80000004)
    static let pointer = HRESULT(bitPattern: 0x80000005)
    static let handle = HRESULT(bitPattern: 0x80000006)
    static let abort = HRESULT(bitPattern: 0x80000007)
    static let fail = HRESULT(bitPattern: 0x80000008)
    static let accessDenied = HRESULT(bitPattern: 0x80000009)
}
