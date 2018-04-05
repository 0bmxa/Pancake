//
//  Defines.swift
//  Pancake
//
//  Created by mxa on 10.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

// swiftlint:disable type_name identifier_name

// MARK: - From CFPluginCOM.h

public struct kUUID {
    /// The IUnknown interface
    static let IUnknown = UUID(
        from: 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
              0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46,
        allocator: kCFAllocatorSystemDefault
    )
}


// MARK: - From AudioServerPlugIn.h

public extension kUUID {
    /// The UUID of the plug-in type (443ABAB8-E7B3-491A-B985-BEB9187030DB).
    static let audioServerPlugInTypeUUID = UUID(from:
        0x44, 0x3A, 0xBA, 0xB8, 0xE7, 0xB3, 0x49, 0x1A,
        0xB9, 0x85, 0xBE, 0xB9, 0x18, 0x70, 0x30, 0xDB
    )

    /// The UUID of the driver interface (EEA5773D-CC43-49F1-8E00-8F96E7D23B17).
    static let audioServerPlugInDriverInterface = UUID(from:
        0xEE, 0xA5, 0x77, 0x3D, 0xCC, 0x43, 0x49, 0xF1,
        0x8E, 0x00, 0x8F, 0x96, 0xE7, 0xD2, 0x3B, 0x17
    )
}


// MARK: - From CFPluginCOM.h

extension HRESULT {
    // Success
    static let ok               = HRESULT(bitPattern: 0x00000000)
    static let `false`          = HRESULT(bitPattern: 0x00000001)

    // Error
    static let unexpected       = HRESULT(bitPattern: 0x8000FFFF)
    static let notImplemented   = HRESULT(bitPattern: 0x80000001)
    static let outOfMemory      = HRESULT(bitPattern: 0x80000002)
    static let invalidArguments = HRESULT(bitPattern: 0x80000003)
    static let noInterface      = HRESULT(bitPattern: 0x80000004)
    static let pointer          = HRESULT(bitPattern: 0x80000005)
    static let handle           = HRESULT(bitPattern: 0x80000006)
    static let abort            = HRESULT(bitPattern: 0x80000007)
    static let fail             = HRESULT(bitPattern: 0x80000008)
    static let accessDenied     = HRESULT(bitPattern: 0x80000009)
}
