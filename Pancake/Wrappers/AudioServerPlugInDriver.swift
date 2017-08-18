//
//  AudioServerPlugInDriver.swift
//  Pancake
//
//  Created by mxa on 11.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

class AudioServerPlugInDriver {
    fileprivate var driverRef: AudioServerPlugInDriverRef
    
    //     MARK: - Init
    init?(from driverRef: AudioServerPlugInDriverRef?) {
        guard let driverRef = driverRef else { return nil }
        self.driverRef = driverRef
    }
    
    init?(from rawPointer: UnsafeMutableRawPointer?) {
        guard let rawPointer = rawPointer else { return nil }
        let opaquePointer = OpaquePointer(rawPointer)
        let driverPointer = AudioServerPlugInDriverRef(opaquePointer)
        self.driverRef = driverPointer
    }
}


    //     MARK: - Accessors
extension AudioServerPlugInDriver {
    var interfacePointer: UnsafeMutablePointer<AudioServerPlugInDriverInterface>? {
        return self.driverRef.pointee
    }
    
    //    var rawPointee: UnsafeMutableRawPointer? {
    //        return UnsafeMutableRawPointer(self.driver.pointee)
    //    }
    
    var interface: AudioServerPlugInDriverInterface? {
        guard let pointee = self.driverRef.pointee else { return nil }
        return pointee.pointee
    }
}


func == (lhs: AudioServerPlugInDriver?, rhs: AudioServerPlugInDriver?) -> Bool {
    return lhs?.driverRef != nil && (lhs?.driverRef == rhs?.driverRef)
}
