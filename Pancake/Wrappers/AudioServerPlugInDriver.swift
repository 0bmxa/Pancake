//
//  AudioServerPlugInDriver.swift
//  Pancake
//
//  Created by mxa on 11.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

final class AudioServerPlugInDriver {
    private typealias AudioServerPlugInDriverRefPointeeType = UnsafeMutablePointer<AudioServerPlugInDriverInterface>?
    fileprivate var driverRef: AudioServerPlugInDriverRef

    // MARK: - Init
    init(from driverRef: AudioServerPlugInDriverRef) {
        self.driverRef = driverRef
    }

    init(from rawPointer: UnsafeMutableRawPointer) {
        let driverPointer = rawPointer.assumingMemoryBound(to: AudioServerPlugInDriverRefPointeeType.self)
        self.driverRef = driverPointer
    }


    // MARK: - Accessors
    var reference: AudioServerPlugInDriverRef {
        return self.driverRef
    }
}


func == (lhs: AudioServerPlugInDriver?, rhs: AudioServerPlugInDriver?) -> Bool {
    return lhs?.driverRef != nil && (lhs?.driverRef == rhs?.driverRef)
}
