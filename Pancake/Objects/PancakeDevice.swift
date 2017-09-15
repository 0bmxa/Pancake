//
//  PancakeDevice.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

class PancakeDevice: PancakeObjectType {
    internal let objectID: AudioObjectID
    private let pancake: Pancake
    
    private let UID: CFString
    
    required init(objectID: AudioObjectID, pancake: Pancake) {
        self.objectID = objectID
        self.pancake = pancake
        
        // FIXME: This should be consistent across boots, not regenerated every time
        self.UID = CFUUIDCreateString(nil, CFUUIDCreate(nil))!
    }

    func getProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty {
        print("###", type(of: self), #function, description.selector)
        
        switch description.selector {
        case .objectBaseClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioObject.classID)
            
        case .objectClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioDevice.classID)
            
        case .deviceUID:
            try assure(CFString.self, fitsIn: sizeHint)
            return .string(self.UID)
            
        case .deviceStreams:
            fatalError()
            
        default:
            print(description)
            assertionFailure()
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
}
