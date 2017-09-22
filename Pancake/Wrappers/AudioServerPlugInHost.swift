//
//  AudioServerPlugInHost.swift
//  Pancake
//
//  Created by mxa on 28.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

class AudioServerPlugInHost {
    private let hostRef: AudioServerPlugInHostRef
    init?(from hostRef: AudioServerPlugInHostRef?) {
        guard let hostRef = hostRef else { return nil }
        self.hostRef = hostRef
    }

    private var hostInterface: AudioServerPlugInHostInterface {
        return self.hostRef.pointee
    }

    func copyFromStorage(key: String) -> (status: OSStatus, data: CFPropertyList?) {
        var format = CFPropertyListFormat.binaryFormat_v1_0
        var propertyList = CFPropertyListCreateWithData(nil, nil, CFOptionFlags(0), &format, nil)
        let status = self.hostInterface.CopyFromStorage(self.hostRef, key as CFString, &propertyList)

        return (status: status, data: propertyList?.takeRetainedValue())
    }
}
