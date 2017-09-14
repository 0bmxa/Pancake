//
//  PancakeDevice.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

class PancakeDevice: PancakeObjectType {
    private let pancake: Pancake
    
    required init(pancake: Pancake = Pancake.shared) {
        self.pancake = pancake
    }
    
    func hasProperty(selector: PancakeAudioObjectPropertySelector) -> Bool {
        switch selector {
            
        default:
            fatalError()
            return false
        }
    }
    
    func getProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty {
        print("### PancakePlugin getProperty:", description.selector)
        
        switch description.selector {
        case .objectBaseClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioObject.classID)
            
        case .objectClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioPlugin.classID)
            
        case .deviceUID:
            fatalError()
            
        default:
            print(description)
            fatalError()
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
}
