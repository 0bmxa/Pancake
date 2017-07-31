//
//  more.swift
//  Pancake
//
//  Created by mxa on 27.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

struct Result<T> {
    let errorCode: HRESULT
    let result: T
}

struct PancakeInheritance {
    func queryInterface(driver: AudioServerPlugInDriver?, UUID: REFIID, interface: Interface) -> HRESULT {

//        let result: Interface? = Interface(from: driver?.rawPointee)
//        return Result(errorCode: 0, result: result)

        guard let driver = driver else { fatalError() }
        interface.setPointee(from: driver)
        
        return 0
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


class AudioServerPlugInDriver {
    private var driver: AudioServerPlugInDriverRef
    
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
