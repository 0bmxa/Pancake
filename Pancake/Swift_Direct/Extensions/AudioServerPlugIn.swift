//
//  AudioServerPlugIn.swift
//  Pancake
//
//  Created by mxa on 20.07.2017.
//  Copyright © 2017 mxa. All rights reserved.
//

import Foundation

// MARK: - CoreAudio/AudioServerPlugIn.h

/// The UUID of the AudioServer plug-in type (443ABAB8-E7B3-491A-B985-BEB9187030DB).
internal let kAudioServerPlugInTypeUUID = CFUUIDGetConstantUUIDWithBytes(nil,
    0x44, 0x3A, 0xBA, 0xB8, 0xE7, 0xB3, 0x49, 0x1A,
    0xB9, 0x85, 0xBE, 0xB9, 0x18, 0x70, 0x30, 0xDB
)
