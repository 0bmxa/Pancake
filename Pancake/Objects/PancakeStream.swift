//
//  PancakeDevice.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

class PancakeStream: PancakeObjectType {
    internal var objectID: AudioObjectID?
    internal weak var owningDevice: PancakeDevice?

    private let pancake: Pancake
    private var active: Bool
    internal let direction: PancakeAudioObjectPropertyScope
    internal let channelCount: UInt32

    /// The absolute starting channel across all streams of the owning device.
    internal var channelOffsetOnOwningDevice: UInt32? = 0


    init(pancake: Pancake, direction: PancakeAudioObjectPropertyScope, channelCount: UInt32) {
        self.pancake = pancake
        self.direction = direction
        self.active = false
        self.channelCount = channelCount
    }

    func getProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty {
        print(type(of: self), #function, description.selector)

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

        case .streamTerminalType:
            try assure(UInt32.self, fitsIn: sizeHint)
            let terminalType = (self.direction == .input) ? kAudioStreamTerminalTypeMicrophone : kAudioStreamTerminalTypeSpeaker
            return .integer(terminalType)


        case .deviceLatency,
             .objectCustomPropertyInfoList,
             .objectName:
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)


        default:
            print("Not implemented:", description.selector)
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }

    func setProperty(description: PancakeObjectPropertyDescription, data: UnsafeRawPointer) throws {
        print(type(of: self), #function, description.selector)
        switch description.selector {
        case .streamIsActive:
            let isActive = data.load(as: UInt32.self)
            self.active = (isActive != 0)

        default:
            print("Not implemented:", description.selector)
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
}
