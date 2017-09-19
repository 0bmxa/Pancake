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
    internal var owningDevice: PancakeDevice? = nil

    private let pancake: Pancake
    private let direction: Direction
    internal let channelCount: Int
    
    /// The absolute starting channel across all streams of the owning device.
    internal var channelOffsetOnOwningDevice: Int? = 0
//    internal let channels: [AudioObjectID]


    init(pancake: Pancake, direction: Direction, channelCount: Int) {
        self.pancake = pancake
        self.direction = direction
        self.channelCount = channelCount
    }

    func getProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty {
        printcake(type(of: self), #function, description.selector)
        
        switch description.selector {
        case .streamStartingChannel:
            try assure(UInt32.self, fitsIn: sizeHint)
            let startingChannel = UInt32(self.channelOffsetOnOwningDevice ?? 0)
            return .integer(startingChannel)
            
        case .streamAvailablePhysicalFormats:
            try assure(AudioStreamRangedDescription.self, fitsIn: sizeHint)
            guard let config = self.owningDevice?.configuration else {
                throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.badObject)
            }
            let streamDescriptions = config.supportedFormats.map { AudioStreamRangedDescription(asbd: $0) }
            let elements = streamDescriptions.limitedTo(avaliableMemory: sizeHint)
            return .streamDescriptionList(elements)
            
        case .streamPhysicalFormat:
            try assure(AudioStreamBasicDescription.self, fitsIn: sizeHint)
            guard let config = self.owningDevice?.configuration else {
                throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.badObject)
            }
            let activeFormat = config.registeredFormat
            let formatToActivate = config.formatToActivate
            guard let newFormat = formatToActivate, newFormat != activeFormat else {
                return .streamDescription(activeFormat)
            }

            // TODO: Notify the host in case the format has changed!
            assertionFailure()
            return .streamDescription(newFormat)


        default:
            printcake("Not implemented:", description.selector)
//            assertionFailure()
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
}

extension PancakeStream {
    enum Direction {
        case input
        case output
    }
}
