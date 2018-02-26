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
    static let noError              = kAudioHardwareNoError                   // The function call completed successfully.
    static let notRunning           = kAudioHardwareNotRunningError           // The function call requires that the hardware be running but it isn't.
    static let unspecified          = kAudioHardwareUnspecifiedError          // The function call failed while doing something that doesn't provide any error messages.
    static let unknownProperty      = kAudioHardwareUnknownPropertyError      // The AudioObject doesn't know about the property at the given address.
    static let badPropertySize      = kAudioHardwareBadPropertySizeError      // An improperly sized buffer was provided when accessing the data of a property.
    static let illegalOperation     = kAudioHardwareIllegalOperationError     // The requested operation couldn't be completed.
    static let badObject            = kAudioHardwareBadObjectError            // The AudioObjectID passed to the function doesn't map to a valid AudioObject.
    static let badDevice            = kAudioHardwareBadDeviceError            // The AudioObjectID passed to the function doesn't map to a valid AudioDevice.
    static let badStream            = kAudioHardwareBadStreamError            // The AudioObjectID passed to the function doesn't map to a valid AudioStream.
    static let unsupportedOperation = kAudioHardwareUnsupportedOperationError // The AudioObject doesn't support the requested operation.
}


/// Error constants unique to the HAL. (From AudioHardwareBase.h)
enum PancakeAudioDeviceError {
    static let unsupportedFormat    = kAudioDeviceUnsupportedFormatError      // The AudioStream doesn't support the requested format.
    static let permissions          = kAudioDevicePermissionsError            // The requested operation can't be completed because the process doesn't have permission.
}
