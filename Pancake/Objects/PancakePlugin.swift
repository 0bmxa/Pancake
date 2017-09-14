//
//  PancakePlugin.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

class PancakePlugin: PancakeObjectType {
    private let pancake: Pancake
    
    required init(pancake: Pancake = Pancake.shared) {
        self.pancake = pancake
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
            
        case .pluginBoxList:
            let expectedNumberOfElements = try numberOfElements(of: AudioObjectID.self, thatFitIn: sizeHint)
            guard expectedNumberOfElements > 0 else {
                return .pancakeObjectIDList([])
            }
            
            // We only have one box, so always return this one
            let boxID = PancakeObjectID.box
            return .pancakeObjectIDList([boxID])
            
            
        case .pluginTranslateUIDToBox:
            fatalError()
            
        case .pluginDeviceList:
            let expectedNumberOfElements = try numberOfElements(of: AudioObjectID.self, thatFitIn: sizeHint)
            guard expectedNumberOfElements > 0 else {
                return .pancakeObjectIDList([])
            }
            
            // Get devices
            let availableDevices = pancake.plugin.devices
            let numberOfElementsToReturn = min(expectedNumberOfElements, availableDevices.count)
            let devices = Array(availableDevices[ 0..<numberOfElementsToReturn ])
            return .pancakeObjectIDList(devices)
            
        case .pluginTranslateUIDToDevice:
            fatalError()
            
        default:
            print(description.selector)
            fatalError()
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
}
