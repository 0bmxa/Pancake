//
//  AudioChannelLayout.swift
//  Pancake
//
//  Created by mxa on 20.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio

// TODO: Create an enum wrapper around the layout tags with two special cases
// (bitmap & descriptions) instead of seperate initializers.


// MARK: - Fixing the channel description part for Swift

extension AudioChannelLayout {
    /// Creates a new channel layout from a channel descriptions array.
    ///
    /// - Parameters:
    ///   - channelDescriptions: A list of channel descriptions.
    init(channelDescriptions: [AudioChannelDescription]) {
        self.mChannelLayoutTag          = kAudioChannelLayoutTag_UseChannelDescriptions
        self.mChannelBitmap             = AudioChannelBitmap(rawValue: 0)
        self.mNumberChannelDescriptions = UInt32(channelDescriptions.count)

        self.mChannelDescriptions = AudioChannelDescription() // Just there to initialize all stored properties...
        self.mChannelDescriptionsArray = channelDescriptions  // <- ...but gets overwritten by this one anyways
    }


    // This is a workaround to make mChannelDescriptions usable in Swift, as
    // it actually is a variable length array, but got bridged as a single
    // element only.

    var mChannelDescriptionsArray: [AudioChannelDescription] {
        mutating get {
            // Note: this is not really mutating, but needs to be declared as
            // such cause we're accessing a pointer here

            // Get pointer to mChannelDescriptions
            var pointer = withUnsafePointer(to: &self.mChannelDescriptions) { $0 }

            // Iterate over mNumberChannelDescriptions number elements in memory
            // and treat them as AudioChannelDescription
            let indices = (0 ..< self.mNumberChannelDescriptions)
            return indices.map { _ -> AudioChannelDescription in
                let element = pointer.pointee
                pointer = pointer.advanced(by: 1)
                return element
            }
        }

        set(array) {
            guard array.count <= self.mNumberChannelDescriptions else {
                fatalError("Not enough memory available.")
            }

            // Get a pointer to mChannelDescriptions
            var channelDescriptionsPointer = withUnsafeMutablePointer(to: &self.mChannelDescriptions) { $0 }

            // Walk over array and write all elements one by one to the memory
            // (Hopefully someone allocated that memory correctly...)
            for element in array {
                channelDescriptionsPointer.pointee = element
                channelDescriptionsPointer = channelDescriptionsPointer.advanced(by: 1)
            }
        }
    }
}



// MARK: - Convenience stuff

extension AudioChannelLayout {
    /// Creates a new channel layout from a layout tag.
    ///
    /// - Parameter channelLayoutTag: A channel layout tag.
    init(channelLayoutTag: AudioChannelLayoutTag) {
        self.mChannelLayoutTag          = channelLayoutTag
        self.mChannelBitmap             = AudioChannelBitmap(rawValue: 0)
        self.mNumberChannelDescriptions = 0
        self.mChannelDescriptions       = AudioChannelDescription()
    }

    /// Creates a new channel layout from a bitmap.
    ///
    /// - Parameter channelBitmap: A channel bitmap.
    private init(channelBitmap: AudioChannelBitmap) {
        self.mChannelLayoutTag          = kAudioChannelLayoutTag_UseChannelBitmap
        self.mChannelBitmap             = channelBitmap
        self.mNumberChannelDescriptions = 0
        self.mChannelDescriptions       = AudioChannelDescription()
    }


    /// Size of the struct for the specified channel count.
    static func size(channelCount: Int) -> UInt32 {
        let basicSize = MemoryLayout<AudioChannelLayout>.stride // contains one channel already
        let additionalChannels = MemoryLayout<AudioChannelDescription>.stride * (channelCount - 1) // the other channels
        return UInt32(basicSize + additionalChannels)
    }

    /// A linear channel layout with the specified number of channels.
    ///
    /// - Parameter channelCount: The number of channels the layout shoudld describe.
    /// - Returns: A new channel layout.
    static func linear(channelCount: UInt32) -> AudioChannelLayout {
        let descriptions = (1...channelCount).map { channelNumber in
            return AudioChannelDescription(mChannelLabel: channelNumber, mChannelFlags: AudioChannelFlags(rawValue: 0), mCoordinates: (0, 0, 0))
        }
        return AudioChannelLayout(channelDescriptions: descriptions)
    }
}
