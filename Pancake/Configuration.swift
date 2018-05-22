//
//  PancakeConfiguration.swift
//  Pancake
//
//  Created by mxa on 18.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.CoreAudioTypes


public struct Configuration {
    /// A list of devices that should be created by Pancake.
    let devices: ContiguousArray<DeviceConfiguration>

    /// A callback function which is called when the plugin is being set up,
    //// i.e. when it's time to set up the audio processor.
    let pluginSetupCallback: (() -> Void)?

    /// Creates an instance of Configuration.
    ///
    /// **Note:** Currently only the first device is created. Any additional
    /// device configurations are ignored.
    ///
    /// - Parameters:
    ///   - devices: The list of devices that should be created.
    ///   - pluginSetupCallback: A callback informing that the plugin is being
    ///     set up. It is okay if it takes some time to return.
    public init(devices: ContiguousArray<DeviceConfiguration>, pluginSetupCallback: (() -> Void)? = nil) {
        self.devices = devices
        self.pluginSetupCallback = pluginSetupCallback
    }
}


internal struct PancakeInternalConfiguration {
    // Stuff from user provided Configuration
    let devices: ContiguousArray<DeviceConfiguration>
    let pluginSetupCallback: (() -> Void)?

    init(from configuration: Configuration) {
        self.devices = configuration.devices
        self.pluginSetupCallback = configuration.pluginSetupCallback
    }
}

public final class DeviceConfiguration {

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

    /// The mach service identifier of the audio routing companion daemon,
    /// associated with the device.
    public var daemonMachServiceName: String

    /// The audio formats the plugin supports.
    public let supportedFormats: ContiguousArray<AudioStreamBasicDescription>

    /// The audio processing callback function to be used to process audio data.
    /// If nil, the device will apply no processing to its stream. (default)
    ///
    /// **Parameters:**
    ///   - buffer: A pointer to the buffer with audio data to be processed
    ///   - frameCount: The number of frames in the buffer.
    ///   - channelCount: The number of channels the buffer.
    ///   - cycle: Details about the current IO cycle.
    public var processingCallback: ((UnsafeMutablePointer<Float32>, UInt32, UInt32, AudioServerPlugInIOCycleInfo) -> Void)?

    // sampleRate, frameCount
    public var startIOCallback: ((Float64, UInt32) -> Void)?
    public var stopIOCallback: ((Float64, UInt32) -> Void)?

    /// Whether the device should be hidden from the user
    public var hidden: Bool = false

    /// Whether the device can be set as the user's default audio device
    public var canBeDefaultDevice: Bool = true

    /// Whether the device can handle system audio like alerts
    public var canHandleSystemAudio: Bool = false

    /// An URL to an icon that visually represents the device, relative to the
    /// bundle.
    public var iconURL: CFURL?

    /// A bundle ID for an app which the user can use to configure the device.
    /// Defaults to the "Audio MIDI Setup" app's bundle ID.
    public var UIAppBundleID: String?


    // MARK: - Internal

    /// The format registered with the host (i.e. the active format)
    internal var registeredFormat: AudioStreamBasicDescription {
        didSet {
            self.ringBuffer.update(format: self.registeredFormat)
            Pancake.shared.setup()
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
    ///   - uid: A unique string to identify the device in a pool of audio.
    ///          objects. This has to be consistent across boots.
    ///   - supportedFormats: The audio formats the plugin supports.
    public init(manufacturer: String? = nil, name: String, UID: String, daemonMachServiceName: String, supportedFormats: ContiguousArray<AudioStreamBasicDescription>) {
        // Public
        self.manufacturer          = manufacturer ?? "Pancake Framework"
        self.name                  = name
        self.UID                   = UID
        self.modelUID              = UID + "_Model" // FIXME:
        self.supportedFormats      = supportedFormats
        self.daemonMachServiceName = daemonMachServiceName

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
