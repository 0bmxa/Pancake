//
//  PancakeAudioObjectPropertyScope.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio

/// A wrapper around AudioObjectPropertyScope
enum PancakeAudioObjectPropertyScope {
    // AudioHardwareBase.h
    case global
    case input
    case output
    case playThrough
    case wildcard
}


// MARK: - RawRepresentable

extension PancakeAudioObjectPropertyScope: RawRepresentable {
    public init?(rawValue: AudioObjectPropertyScope) {
        switch rawValue {
        case kAudioObjectPropertyScopeGlobal:      self = .global
        case kAudioObjectPropertyScopeInput:       self = .input
        case kAudioObjectPropertyScopeOutput:      self = .output
        case kAudioObjectPropertyScopePlayThrough: self = .playThrough
        case kAudioObjectPropertyScopeWildcard:    self = .wildcard
        default: return nil
        }
    }
    public var rawValue: AudioObjectPropertyScope {
        switch self {
        case .global:      return kAudioObjectPropertyScopeGlobal
        case .input:       return kAudioObjectPropertyScopeInput
        case .output:      return kAudioObjectPropertyScopeOutput
        case .playThrough: return kAudioObjectPropertyScopePlayThrough
        case .wildcard:    return kAudioObjectPropertyScopeWildcard
        }
    }
}
