//
//  BasicOperations.swift
//  Pancake
//
//  Created by mxa on 16.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import Foundation
import CoreAudio.AudioServerPlugIn

extension Pancake {

    func initialize(driver: AudioServerPlugInDriver?, host: AudioServerPlugInHost?) -> OSStatus {
        guard driver == self.driver else {
            return kAudioHardwareBadObjectError
        }
        
        self.host = host
        
        //
        
        return 0
    }
    
    
    
    func createDevice(inDriver: AudioServerPlugInDriverRef, inDescription: CFDictionary, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>, outDeviceObjectID: UnsafeMutablePointer<AudioObjectID>) -> OSStatus {
        return 0
    }
    func destroyDevice(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID) -> OSStatus {
        return 0
    }
    func addDeviceClient(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus {
        return 0
    }
    func removeDeviceClient(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inClientInfo: UnsafePointer<AudioServerPlugInClientInfo>) -> OSStatus {
        return 0
    }
    func performDeviceConfigurationChange(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inChangeAction: UInt64, inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus {
        return 0
    }
    func abortDeviceConfigurationChange(inDriver: AudioServerPlugInDriverRef, inDeviceObjectID: AudioObjectID, inChangeAction: UInt64, inChangeInfo: UnsafeMutableRawPointer?) -> OSStatus {
        return 0
    }
 
}

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
