//
//  PancakeAudioObjectPropertyElement.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioHardwareBase

enum PancakeAudioObjectPropertyElement {
    // AudioHardwareBase.h
    case master
    case wildcard
    case other(AudioObjectPropertyElement)
}

extension PancakeAudioObjectPropertyElement: RawRepresentable {
    public init(rawValue: AudioObjectPropertyElement) {
        switch rawValue {
        case kAudioObjectPropertyElementMaster:   self = .master
        case kAudioObjectPropertyElementWildcard: self = .wildcard
        default:                                  self = .other(rawValue)
        }
    }
    public var rawValue: AudioObjectPropertyElement {
        switch self {
        case .master:           return kAudioObjectPropertyElementMaster
        case .wildcard:         return kAudioObjectPropertyElementWildcard
        case .other(let value): return value
        }
    }
}
