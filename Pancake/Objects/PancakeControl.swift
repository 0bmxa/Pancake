//
//  PancakeDevice.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

class PancakeControl: PancakeObjectType {
    internal var objectID: AudioObjectID?
    
    private let controlType: ControlType
    private let scope: PancakeAudioObjectPropertyScope
    private let element: PancakeAudioObjectPropertyElement
    
    private var volume: Float32 = 0 // TODO: this should not be here
    

    init(type: ControlType, scope: PancakeAudioObjectPropertyScope, element: PancakeAudioObjectPropertyElement) {
        self.controlType = type
        self.scope       = scope
        self.element     = element
    }
    
    func getProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty {
        printcake(type(of: self), #function, description.selector)
        
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

        case .objectCustomPropertyInfoList:
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)

        case .levelControlScalarValue:
            try assure(Float32.self, fitsIn: sizeHint)
            return .float32(self.volume)
            
        default:
            printcake("Not implemented:", description.selector)
            //assertionFailure()
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
    
    func setProperty(description: PancakeObjectPropertyDescription, data: UnsafeRawPointer) throws {
        switch description.selector {
        //case .<#pattern#>:
            
        case .levelControlScalarValue:
            let myData = data.assumingMemoryBound(to: Float32.self)
            self.volume = myData.pointee
            
        default:
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
}

extension PancakeControl {
    enum ControlType {
        case slider
        case level
        case boolean
        case selector
        case stereoPan
        
        case mute
        case solo
        case jack
        case LFEMute
        case phantomPower
        case phaseInvert
        case clipLight
        case talkback
        case listenback
        case dataSource
        case dataDestination
        case clockSource
        case lineLevel
        case highPassFilter
        case volume
        case LFEVolume
        
        var classID: AudioClassID {
            switch self {
            case .slider:          return PancakeAudioControlClassID.slider
            case .level:           return PancakeAudioControlClassID.level
            case .boolean:         return PancakeAudioControlClassID.boolean
            case .selector:        return PancakeAudioControlClassID.selector
            case .stereoPan:       return PancakeAudioControlClassID.stereoPan
            case .mute:            return PancakeAudioControlClassID.mute
            case .solo:            return PancakeAudioControlClassID.solo
            case .jack:            return PancakeAudioControlClassID.jack
            case .LFEMute:         return PancakeAudioControlClassID.LFEMute
            case .phantomPower:    return PancakeAudioControlClassID.phantomPower
            case .phaseInvert:     return PancakeAudioControlClassID.phaseInvert
            case .clipLight:       return PancakeAudioControlClassID.clipLight
            case .talkback:        return PancakeAudioControlClassID.talkback
            case .listenback:      return PancakeAudioControlClassID.listenback
            case .dataSource:      return PancakeAudioControlClassID.dataSource
            case .dataDestination: return PancakeAudioControlClassID.dataDestination
            case .clockSource:     return PancakeAudioControlClassID.clockSource
            case .lineLevel:       return PancakeAudioControlClassID.lineLevel
            case .highPassFilter:  return PancakeAudioControlClassID.highPassFilter
            case .volume:          return PancakeAudioControlClassID.volume
            case .LFEVolume:       return PancakeAudioControlClassID.LFEVolume
            }
        }
    }
}
