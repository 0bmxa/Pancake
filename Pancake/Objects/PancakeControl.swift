//
//  PancakeDevice.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

final class PancakeControl: PancakeObjectType {
    internal var objectID: AudioObjectID?

    private let controlType: PancakeAudioControl
    private let scope: PancakeAudioObjectPropertyScope
    private let element: PancakeAudioObjectPropertyElement

    private var value: Float32 = 1.0 // TODO: this should probably be saved


    init(type: PancakeAudioControl, scope: PancakeAudioObjectPropertyScope, element: PancakeAudioObjectPropertyElement) {
        self.controlType = type
        self.scope       = scope
        self.element     = element
    }

    func getProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty {
        print(type(of: self), #function, description.selector)

        switch description.selector {
        case .objectClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(self.controlType.classID)

        case .objectBaseClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioObject.classID)

        case .controlScope:
            try assure(AudioObjectPropertyScope.self, fitsIn: sizeHint)
            return .scope(self.scope.rawValue)

        case .controlElement:
            try assure(AudioObjectPropertyElement.self, fitsIn: sizeHint)
            return .element(self.element.rawValue)

        case .levelControlScalarValue:
            try assure(Float32.self, fitsIn: sizeHint)
            return .float32(self.value)

        case .levelControlDecibelValue:
            try assure(Float32.self, fitsIn: sizeHint)
            let decibelVolume = 20 * log(self.value)
            return .float32(decibelVolume)

        case .levelControlDecibelRange:
            try assure(AudioValueRange.self, fitsIn: sizeHint)
            let decibelRange = AudioValueRange(mMinimum: -140, mMaximum: 0)
            return .valueRange(decibelRange)

        case .objectCustomPropertyInfoList:
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)

        default:
            print("Not implemented:", description.selector)
            //assertionFailure()
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }

    func setProperty(description: PancakeObjectPropertyDescription, data: UnsafeRawPointer) throws {
        print(type(of: self), #function, description.selector)
        switch description.selector {
        //case .<#pattern#>:

        case .levelControlScalarValue:
            let dataPointer = data.assumingMemoryBound(to: Float32.self)
            let scalarValue = dataPointer.pointee
            self.value = scalarValue.clampedTo(min: 0.0, max: 1.0)

        case .levelControlDecibelValue:
            let dataPointer = data.assumingMemoryBound(to: Float32.self)
            let decibelValue = dataPointer.pointee
            let scalarValue = pow(10, decibelValue/20)
            self.value = scalarValue.clampedTo(min: 0.0, max: 1.0)

        default:
            print("Not implemented:", description.selector)
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
}
