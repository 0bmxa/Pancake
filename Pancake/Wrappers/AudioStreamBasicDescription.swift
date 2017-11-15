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
}



// MARK: - ASRD

extension AudioStreamRangedDescription {
    init(asbd: AudioStreamBasicDescription) {
        self.mFormat = asbd
        self.mSampleRateRange = AudioValueRange(mMinimum: asbd.mSampleRate, mMaximum: asbd.mSampleRate)
    }
}
