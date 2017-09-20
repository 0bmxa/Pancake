//
//  PancakePlugin.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

class PancakePlugin: PancakeObjectType {
    internal var objectID: AudioObjectID? = nil
    private let pancake: Pancake
    
    init(pancake: Pancake) {
        self.pancake = pancake
    }

    func getProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty {
        printcake(type(of: self), #function, description.selector)
        
        switch description.selector {
        case .objectBaseClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioObject.classID)
            
        case .objectClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioPlugin.classID)
            
        case .pluginBoxList,
             .hardwareBoxList: // not sure the hardware box list should include _all_ boxes or just ours...
            try assure(AudioObjectID.self, fitsIn: sizeHint)
            let boxes = self.pancake.audioObjects.IDsForObjects(of: PancakeBox.self)
            let elements = boxes.limitedTo(avaliableMemory: sizeHint)
            return .pancakeObjectIDList(elements)

        case .pluginDeviceList,
             .hardwareDevices: // not sure the hardware device list should include _all_ devices or just ours...
            try assure(AudioObjectID.self, fitsIn: sizeHint)
            let devices = self.pancake.audioObjects.IDsForObjects(of: PancakeDevice.self)
            let elements = devices.limitedTo(avaliableMemory: sizeHint)
            return .pancakeObjectIDList(elements)
            
        case .pluginResourceBundle:
            try assure(CFString.self, fitsIn: sizeHint)
            let pathRelativeToPlugin = "" as CFString
            return .string(pathRelativeToPlugin)

        case .objectCustomPropertyInfoList,
             .hardwareClockDeviceList:
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
            

        default:
            printcake("Not implemented:", description.selector)
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
    
    func setProperty(description: PancakeObjectPropertyDescription, data: UnsafeRawPointer) throws {
        switch description.selector {
            //case .<#pattern#>:
            
            
        default:
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
}



