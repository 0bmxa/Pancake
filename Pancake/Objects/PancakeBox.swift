//
//  PancakeDevice.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

class PancakeBox: PancakeObjectType {
    internal var objectID: AudioObjectID?
    private let pancake: Pancake

    private let UID: CFString
    private let name: CFString

    init(pancake: Pancake, UID: String, name: String) {
        self.pancake = pancake
        self.UID = UID as CFString
        self.name = name as CFString
    }

    func getProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty {
        print(type(of: self), #function, description.selector)

        switch description.selector {
        case .objectBaseClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioObject.classID)

        case .objectClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioBox.classID)

        case .objectName:
            try assure(CFString.self, fitsIn: sizeHint)
            return .string(self.name)

        case .boxUID:
            try assure(CFString.self, fitsIn: sizeHint)
            return .string(self.UID)

        case .objectCustomPropertyInfoList:
            try assure(AudioServerPlugInCustomPropertyInfo.self, fitsIn: sizeHint)
            let customProperties = self.pancake.customProperties
            let elements = customProperties.limitedTo(avaliableMemory: sizeHint)
            return .customPropertyInfoList(elements)

        default:
            print("Not implemented:", description.selector)
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }

    func setProperty(description: PancakeObjectPropertyDescription, data: UnsafeRawPointer) throws {
        print(type(of: self), #function, description.selector)
        switch description.selector {
            //case .<#pattern#>:


        default:
            print("Not implemented:", description.selector)
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
}
