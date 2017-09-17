//
//  PancakeDevice.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

class PancakeStream: PancakeObjectType {
    internal var objectID: AudioObjectID? = nil
    private let pancake: Pancake

//    internal weak var owningDevice: PancakeDevice? = nil
    internal var channelOffsetOnOwningDevice: Int? = 0
    internal let channels: [AudioObjectID]

    required init(pancake: Pancake) {
        self.pancake = pancake
        self.channels = [] // todo:
    }

    func getProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty {
        print("###", type(of: self), #function, description.selector)
        
        switch description.selector {
        case .streamStartingChannel:
            try assure(UInt32.self, fitsIn: sizeHint)
            let startingChannel = UInt32(self.channelOffsetOnOwningDevice ?? 0)
            return .integer(startingChannel)
            
        case .streamAvailablePhysicalFormats:
            try assure(AudioStreamRangedDescription.self, fitsIn: sizeHint)
            let streamDescriptions = self.pancake.configuration.descriptions.limitedTo(avaliableMemory: sizeHint)
            return .streamDescriptionList(streamDescriptions)
            
        case .objectCustomPropertyInfoList:
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
            
        default:
            print(description)
            assertionFailure()
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
}
