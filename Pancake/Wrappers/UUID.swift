//
//  UUID.swift
//  Pancake
//
//  Created by mxa on 19.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreFoundation

struct UUID {
    private let _UUID: CFUUID
    private let allocator: CFAllocator?
    
    /// Creates a new random UUID.
    init(allocator: CFAllocator? = nil) {
        self._UUID = CFUUIDCreate(allocator)
        self.allocator = allocator
    }
    
    /// Creates a new UUID from the given 16 bytes.
    init(from bytes: UInt8 ..., allocator: CFAllocator? = nil) {
        self.init(from: CFUUIDBytes(bytes), allocator:allocator)
    }

    /// Creates a new UUID from the given CFUUIDBytes.
    init(from bytes: CFUUIDBytes, allocator: CFAllocator? = nil) {
        self._UUID = CFUUIDCreateFromUUIDBytes(allocator, bytes)
        self.allocator = allocator
    }

    /// String representaiton of the UUID.
    var string: String {
        return CFUUIDCreateString(self.allocator, self._UUID)! as String
    }
}

extension UUID: RawRepresentable {
    typealias RawValue = CFUUID

    init?(rawValue: CFUUID) {
        self._UUID = rawValue
        self.allocator = nil
    }
    
    var rawValue: CFUUID {
        return self._UUID
    }
}

extension CFUUIDBytes {
    init(_ bytes: UInt8 ...) {
        self.init(bytes)
    }
    
    init(_ bytes: [UInt8]) {
        guard bytes.count == 16 else { fatalError() }
        self.init(
            byte0:  bytes[0],
            byte1:  bytes[1],
            byte2:  bytes[2],
            byte3:  bytes[3],
            byte4:  bytes[4],
            byte5:  bytes[5],
            byte6:  bytes[6],
            byte7:  bytes[7],
            byte8:  bytes[8],
            byte9:  bytes[9],
            byte10: bytes[10],
            byte11: bytes[11],
            byte12: bytes[12],
            byte13: bytes[13],
            byte14: bytes[14],
            byte15: bytes[15]
        )
    }
}

func == (lhs: UUID?, rhs: UUID?) -> Bool {
    return lhs != nil && CFEqual(lhs?.rawValue, rhs?.rawValue)
}
