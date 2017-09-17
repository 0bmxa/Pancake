//
//  PancakeDevice.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

class PancakeBox: PancakeObjectType {
    internal var objectID: AudioObjectID? = nil
    private let pancake: Pancake

    private let UID: CFString

    required init(pancake: Pancake) {
        self.pancake = pancake
        
        // FIXME: This should be consistent across boots, not regenerated every time
        self.UID = CFUUIDCreateString(nil, CFUUIDCreate(nil))!
    }

    func getProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty {
        print("###", type(of: self), #function, description.selector)
        
        switch description.selector {
//        case .objectBaseClass:
//            try assure(AudioClassID.self, fitsIn: sizeHint)
//            return .audioClassID(PancakeAudioPlugin.classID)
//
//        case .objectClass:
//            try assure(AudioClassID.self, fitsIn: sizeHint)
//            return .audioClassID(PancakeAudioBox.classID)

        case .boxUID:
            try assure(CFString.self, fitsIn: sizeHint)
            return .string(self.UID)
            
        case .objectCustomPropertyInfoList:
            try assure(AudioServerPlugInCustomPropertyInfo.self, fitsIn: sizeHint)
            let customProperties = self.pancake.customProperties
            let elements = customProperties.limitedTo(avaliableMemory: sizeHint)
            return .customPropertyInfoList(elements)

        default:
            print(description)
            assertionFailure()
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
}
