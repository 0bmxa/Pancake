//
//  AudioStreamBasicDescription.swift
//  Pancake
//
//  Created by mxa on 17.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio

// MARK: - ASBD

extension AudioStreamBasicDescription {
    enum AudioDataFormat {
        case int16
        case fixedPoint824
        case float32
        case float64

        var size: UInt32 {
            switch self {
            case .int16:         return 2
            case .fixedPoint824: return 4
            case .float32:       return 4
            case .float64:       return 8
            }
        }

        var flags: [AudioFormatFlags] {
            switch self {
            case .int16:         return [kAudioFormatFlagIsSignedInteger]
            case .fixedPoint824: return [kAudioFormatFlagIsSignedInteger, 24 << kLinearPCMFormatFlagsSampleFractionShift]
            case .float32:       return [kAudioFormatFlagIsFloat]
            case .float64:       return [kAudioFormatFlagIsFloat]
            }
        }
    }

    private static let availableFlags = [
        "IsFloat":                    kAudioFormatFlagIsFloat,
        "IsBigEndian":                kAudioFormatFlagIsBigEndian,
        "IsSignedInteger":            kAudioFormatFlagIsSignedInteger,
        "IsPacked":                   kAudioFormatFlagIsPacked,
        "IsAlignedHigh":              kAudioFormatFlagIsAlignedHigh,
        "IsNonInterleaved":           kAudioFormatFlagIsNonInterleaved,
        "IsNonMixable":               kAudioFormatFlagIsNonMixable,
        "AreAllClear":                kAudioFormatFlagsAreAllClear,
        //"Canonical":                  kAudioFormatFlagsCanonical,
        //"AudioUnitCanonical":         kAudioFormatFlagsAudioUnitCanonical,
        "(LPCM)SampleFractionShift":  kLinearPCMFormatFlagsSampleFractionShift,
        "(LPCM)SampleFractionMask":   kLinearPCMFormatFlagsSampleFractionMask,
        "(Lossless)16BitSourceData":  kAppleLosslessFormatFlag_20BitSourceData,
        "(Lossless)20BitSourceData":  kAppleLosslessFormatFlag_20BitSourceData,
        "(Lossless)24BitSourceData":  kAppleLosslessFormatFlag_24BitSourceData,
        "(Lossless)32BitSourceData":  kAppleLosslessFormatFlag_32BitSourceData,
        ]


    /// Creates a new ASBD from the specified parameters, calculating the rest
    /// of the ASBD struct internally.
    ///
    /// - Parameters:
    ///   - sampleRate: The sample rate.
    ///   - channelCount: The number of channels which logically belong together.
    ///   - format: The byte format of the audio data.
    init(sampleRate: Float64, channelCount: UInt32, format: AudioDataFormat) {
        self.init(sampleRate: sampleRate, channelCount: channelCount, format: format, interleaved: true)
    }


    /// Creates a new ASBD from the specified parameters, calculating the rest
    /// of the ASBD struct internally.
    /// Note: Interleaved format switch is implemented, but non-interleaved
    ///       audio is not supported by the audio hardware.
    ///
    /// - Parameters:
    ///   - sampleRate: The sample rate.
    ///   - channelCount: The number of channels which logically belong together.
    ///   - format: The byte format of the audio data.
    ///   - interleaved: Whether the format is interleaved or not.
    private init(sampleRate: Float64, channelCount: UInt32, format: AudioDataFormat, interleaved: Bool) {
        let formatID         = kAudioFormatLinearPCM
        let framesPerPacket  = UInt32(1)
        let bitsPerChannel   = format.size * 8

        var bytesPerFrame = format.size
        var flags = [kAudioFormatFlagsNativeEndian, kAudioFormatFlagIsPacked] + format.flags
        if interleaved {
            bytesPerFrame *= channelCount
        } else {
            flags += [kAudioFormatFlagIsNonInterleaved]
        }

        let formatFlags = flags.reduce(0) { $0 | $1 }

        self.init(mSampleRate: sampleRate, mFormatID: formatID, mFormatFlags: formatFlags, mFramesPerPacket: framesPerPacket, mBytesPerFrame: bytesPerFrame, mChannelsPerFrame: channelCount, mBitsPerChannel: bitsPerChannel)
    }

    // The init how it should be
    init(mSampleRate: Float64, mFormatID: AudioFormatID, mFormatFlags: AudioFormatFlags, mFramesPerPacket: UInt32, mBytesPerFrame: UInt32, mChannelsPerFrame: UInt32, mBitsPerChannel: UInt32) {
        self.mSampleRate       = mSampleRate
        self.mFormatID         = mFormatID
        self.mFormatFlags      = mFormatFlags
        self.mFramesPerPacket  = mFramesPerPacket
        self.mBytesPerFrame    = mBytesPerFrame
        self.mChannelsPerFrame = mChannelsPerFrame
        self.mBitsPerChannel   = mBitsPerChannel

        self.mBytesPerPacket   = mBytesPerFrame * mFramesPerPacket
        self.mReserved         = 0
    }

    static func == (lhs: AudioStreamBasicDescription, rhs: AudioStreamBasicDescription) -> Bool {
        return (
            lhs.mSampleRate       == rhs.mSampleRate       &&
                lhs.mFormatID         == rhs.mFormatID         &&
                lhs.mFormatFlags      == rhs.mFormatFlags      &&
                lhs.mFramesPerPacket  == rhs.mFramesPerPacket  &&
                lhs.mBytesPerFrame    == rhs.mBytesPerFrame    &&
                lhs.mChannelsPerFrame == rhs.mChannelsPerFrame &&
                lhs.mBitsPerChannel   == rhs.mBitsPerChannel   &&
                lhs.mBytesPerPacket   == rhs.mBytesPerPacket   &&
                lhs.mReserved         == rhs.mReserved
        )
    }

    static func != (lhs: AudioStreamBasicDescription, rhs: AudioStreamBasicDescription) -> Bool {
        return !(lhs == rhs)
    }

    func has(flag: AudioFormatFlags) -> Bool {
        return (self.mFormatFlags & flag == flag)
    }

    private var formatFlags: String {
        return AudioStreamBasicDescription.availableFlags
            .filter { self.has(flag: $0.value) }
            .keys
            .map { $0.hasPrefix("Is") ? $0.suffix(from: 2)! : $0 }
            .joined(separator: ", ")
    }

    private var formatID: String {
        var formatID = self.mFormatID
        let formatIDPointer = withUnsafeMutablePointer(to: &formatID) { $0 }
        let cCharFormatID = formatIDPointer.withMemoryRebound(to: CChar.self, capacity: 4) { $0 }
        let formatString = String(cString: cCharFormatID)
        return String(formatString.reversed())
    }
}


// MARK: - String Convertible
extension AudioStreamBasicDescription: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return
            "ASBD: \(self.formatID) (\(self.formatFlags)) " +
                "@ \(self.mSampleRate) Hz, \(self.mChannelsPerFrame) Ch, " +
        "[\(self.mFramesPerPacket)|\(self.mBytesPerPacket)|\(self.mBytesPerFrame)|\(self.mBitsPerChannel)]"
    }

    public var debugDescription: String {
        return
            "ASBD:\n" +
                "  FormatID:         \(self.formatID)\n" +
                "  SampleRate:       \(self.mSampleRate)\n" +
                "  FormatFlags:      \(self.formatFlags)\n" +
                "  ChannelsPerFrame: \(self.mChannelsPerFrame)\n" +
                "  FramesPerPacket:  \(self.mFramesPerPacket)\n" +
                "  BytesPerPacket:   \(self.mBytesPerPacket)\n" +
                "  BytesPerFrame:    \(self.mBytesPerFrame)\n" +
                "  BitsPerChannel:   \(self.mBitsPerChannel)\n" +
        ""
    }
}


// MARK: - ASRD

extension AudioStreamRangedDescription {
    init(asbd: AudioStreamBasicDescription) {
        self.mFormat = asbd
        self.mSampleRateRange = AudioValueRange(mMinimum: asbd.mSampleRate, mMaximum: asbd.mSampleRate)
    }
}
