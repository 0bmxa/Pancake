//
//  PancakeAudioError.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio

/// Error constants unique to the HAL. (From AudioHardwareBase.h)
enum PancakeAudioHardwareError {
    static let noError              = kAudioHardwareNoError
    static let notRunning           = kAudioHardwareNotRunningError
    static let unspecified          = kAudioHardwareUnspecifiedError
    static let unknownProperty      = kAudioHardwareUnknownPropertyError
    static let badPropertySize      = kAudioHardwareBadPropertySizeError
    static let illegalOperation     = kAudioHardwareIllegalOperationError
    static let badObject            = kAudioHardwareBadObjectError
    static let badDevice            = kAudioHardwareBadDeviceError
    static let badStream            = kAudioHardwareBadStreamError
    static let unsupportedOperation = kAudioHardwareUnsupportedOperationError
}


/// Error constants unique to the HAL. (From AudioHardwareBase.h)
enum PancakeAudioDeviceError {
    static let unsupportedFormat = kAudioDeviceUnsupportedFormatError
    static let permissions       = kAudioDevicePermissionsError
}

