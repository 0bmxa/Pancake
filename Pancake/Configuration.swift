//
//  PancakeConfiguration.swift
//  Pancake
//
//  Created by mxa on 18.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio
//import AppKit
import Foundation


public struct Configuration {
    /// A list of devices that should be created by Pancake.
    let devices: [DeviceConfiguration]

    /// Creates an instance of Configuration.
    ///
    /// - Parameter devices: The list of devices that should be created.
    ///   NOTE: Currently only the first device is used. The others are ignored.
    init(devices: [DeviceConfiguration]) {
        self.devices = devices
    }
}


internal struct PancakeInternalConfiguration {
    // Stuff from user provided Configuration
    let devices: [DeviceConfiguration]
}

public class DeviceConfiguration {

    // MARK: - Public

    /// The device vendor.
    public let manufacturer: String

    /// The device name.
    public let name: String

    /// A unique string to identify the device in a pool of audio objects.
    /// This has to be consistent across boots.
    public let UID: String

    /// A unique string to identify the device in a pool of audio objects.
    /// This has to be consistent across boots.
    public let modelUID: String

    /// The audio formats the plugin supports.
    public let supportedFormats: [AudioStreamBasicDescription]

    /// Whether the device should be hidden from the user
    public var hidden: Bool = false

    /// Whether the device can be set as the user's default audio device
    public var canBeDefaultDevice: Bool = true

    /// Whether the device can handle system audio like alerts
    public var canHandleSystemAudio: Bool = false

    /// An URL to an icon that visually represents the device, relative to the
    /// bundle.
    public var iconURL: URL?

    /// A bundle ID for an app which the user can use to configure the device.
    /// Defaults to the "Audio MIDI Setup" app's bundle ID.
    public var UIAppBundleID: String?


    // MARK: - Internal

    /// The format registered with the host (i.e. the active format)
    internal var registeredFormat: AudioStreamBasicDescription {
        didSet {
            self.ringBuffer.update(format: self.registeredFormat)
        }
    }

    // The next format to register with the host
    internal var formatToActivate: AudioStreamBasicDescription?

    /// The IO ring buffer
    internal let ringBuffer: RingBuffer

    /// Offsets after which it is safe to do IO
    internal let safetyOffsets: InOutValue<UInt32>

    /// Device latency
    internal let deviceLatency: InOutValue<UInt32>


    /// The number of host ticks per frame, based on the currently active format
    internal var ticksPerFrame: Float64 {
        let ticksPerSecond = MachTimebaseInfo().ticksPerSecond
        return ticksPerSecond / self.registeredFormat.mSampleRate
    }

    /// The number of host ticks per ring buffer (i.e. all frames in the buffer)
    internal var ticksPerRingBuffer: Float64 {
        return self.ticksPerFrame * Float64(self.ringBuffer.frames)
    }


    /// Creates a new device configuration.
    ///
    /// - Parameters:
    ///   - manufacturer: The device vendor.
    ///   - name: The device name.
    ///   - uid: A unique string to identify the device in a pool of audio objects. This has to be consistent across boots.
    ///   - supportedFormats: The audio formats the plugin supports.
    ///   - hidden: Whether the device should be hidden from the user. (Default: no)
    ///   - canBeDefaultDevice: Whether the device can be set as the user's default audio device. (Default: yes)
    ///   - canHandleSystemAudio: Whether the device can handle system audio like alerts. (Default: no)
    public init(manufacturer: String, name: String, UID: String, supportedFormats: [AudioStreamBasicDescription]) {
        // Public
        self.manufacturer         = manufacturer
        self.name                 = name
        self.UID                  = UID
        self.modelUID             = UID + "_Model" // FIXME:
        self.supportedFormats     = supportedFormats

        // Internal
        self.registeredFormat = supportedFormats[0]
        self.ringBuffer       = RingBuffer(frames: 1024 * 2 * 8, format: self.registeredFormat)
        self.safetyOffsets    = InOutValue(input: 0, output: 128)
        self.deviceLatency    = InOutValue(input: 0, output: 0)
    }
}



struct InOutValue<T> {
    let input: T
    let output: T

    func value(for scope: PancakeAudioObjectPropertyScope) -> T {
        switch scope {
        case .input:  return self.input
        case .output: return self.output
        default: fatalError("Unsupported scope: \(scope)")
        }
    }
}
