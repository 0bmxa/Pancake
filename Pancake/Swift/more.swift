//
//  more.swift
//  Pancake
//
//  Created by mxa on 27.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

//struct Result<E, R> {
//    let errorCode: E
//    let result: R
//}

struct AtomicCounter {
    private var value: UInt = 0
    private let serialQueue = DispatchQueue(label: "")
    
    mutating func increment() {
        self.value += 1
    }

    mutating func decrement() {
        self.value -= 1
    }
}


class PancakeInheritance {
    
    private let driverReference: AudioServerPlugInDriver
    private var pluginReferencesCounter: AtomicCounter
    
    init(driverReference: AudioServerPlugInDriver) {
        self.driverReference = driverReference
        self.pluginReferencesCounter = AtomicCounter()
    }

    /// Finds the interface to talk to the plug-in.
    /// A AudioServerPlugIn wrapper method.
    ///
    /// - Parameters:
    ///   - driver: The CFPlugIn type to query.
    ///   - UUID: The UUID of the interface to find.
    /// - Returns: The returned interface or nil if none was found, and an error code indicating success of failure..
    func queryInterface(driver: AudioServerPlugInDriver?, UUID: CFUUID?, writeTo outInterface: Interface?) -> HRESULT {
        
        guard let driver = driver else {
            return kAudioHardwareBadObjectError
        }
        
        guard driver == self.driverReference else {
            print(driver, self.driverReference)
            return kAudioHardwareBadObjectError
        }
        
        guard let interface = outInterface, let UUID = UUID else {
            return kAudioHardwareIllegalOperationError
        }
        
        guard UUID == kUUID.IUnknown || UUID == kUUID.audioServerPlugInDriverInterface else {
            return HRESULT.noInterface
        }
        
        self.pluginReferencesCounter.increment()
        interface.setPointee(from: driver)
    
        return HRESULT.ok
    }
    
    func addRef(driver: AudioServerPlugInDriverRef?) -> ULONG {
        return 0
    }
    
    func release(driver: AudioServerPlugInDriverRef?) -> ULONG {
        return 0
    }
}


//extension MemoryLayout where T == AudioServerPlugInDriverInterface {
//    static var size: Int {
//        return 8
//    }
//}

//func makeAudioServerPlugInDriverRef(_ rawPointer: UnsafeMutableRawPointer) -> AudioServerPlugInDriverRef {
////func makeAudioServerPlugInDriverRef(_ rawPointer: UnsafeMutableRawPointer) {
////    let pointer = MemoryLayout<AudioServerPlugInDriverInterface>.size
////    let p = UnsafeMutablePointer<Int>.allocate(capacity: 1)
//    let opaquePointer = OpaquePointer(rawPointer)
//    let driver = UnsafeMutablePointer<UnsafeMutablePointer<AudioServerPlugInDriverInterface>?>(opaquePointer)
//    return driver
//}


func == (lhs: AudioServerPlugInDriver, rhs: AudioServerPlugInDriver) -> Bool {
    return lhs.driver == rhs.driver
}


class AudioServerPlugInDriver {
    fileprivate var driver: AudioServerPlugInDriverRef
    
//     MARK: - Init

    init?(from driver: AudioServerPlugInDriverRef?) {
        guard let driver = driver else { return nil }
        self.driver = driver
    }
    
    init?(from rawPointer: UnsafeMutableRawPointer?) {
        guard let rawPointer = rawPointer else { return nil }
        let opaquePointer = OpaquePointer(rawPointer)
        let driverPointer = AudioServerPlugInDriverRef(opaquePointer)
        self.driver = driverPointer
    }

    
//     MARK: - Accessors
    var pointee: UnsafeMutablePointer<AudioServerPlugInDriverInterface>? {
        return self.driver.pointee
    }
    
//    var rawPointee: UnsafeMutableRawPointer? {
//        return UnsafeMutableRawPointer(self.driver.pointee)
//    }
    
    var interface: AudioServerPlugInDriverInterface? {
        guard let pointee = self.driver.pointee else { return nil }
        return pointee.pointee
    }
}

class Interface {
    private var pointer: UnsafeMutablePointer<UnsafeMutableRawPointer?>
    
    init?(from pointer: UnsafeMutablePointer<UnsafeMutableRawPointer?>?) {
        guard let pointer = pointer else { return nil }
        self.pointer = pointer
    }
    
//    init?(for driver: AudioServerPlugInDriver?) {
//        guard let driver = driver else { return nil }
//        self.pointer = driver.
//    }
    
    func setPointee(from driver: AudioServerPlugInDriver) {
        self.pointer.pointee = UnsafeMutableRawPointer(driver.pointee)
    }
}
