//
//  PancakeDevice.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

class PancakeDevice: PancakeObjectType {
    internal var objectID: AudioObjectID?

    private let pancake: Pancake
    internal let configuration: DeviceConfiguration
    private var controls: [PancakeControl]
    internal let streams: [PancakeStream] // internal because device IO extenseion

    // IO / timing stuff
    internal var IOCount = AtomicCounter<UInt64>() // internal because device IO extenseion
    internal var cycleCount = AtomicCounter<UInt64>() // internal because device IO extenseion
    internal var referenceHostTime = AtomicCounter<UInt64>() // internal because device IO extenseion


    init(pancake: Pancake, streams: [PancakeStream], configuration: DeviceConfiguration) {
        self.pancake       = pancake
        self.streams       = streams
        self.configuration = configuration
        self.controls      = []

        self.createControls()
        self.updateStreamConfig()
    }

    /// Walks over all streams and updates their channel offset
    private func updateStreamConfig() {
        var totalChannelCount = 0
        self.streams.forEach { stream in
            stream.channelOffsetOnOwningDevice = totalChannelCount
            stream.owningDevice = self
            totalChannelCount += stream.channelCount
        }
    }

    private func createControls() {
        // Master volume controls
        let inputMasterVolumeControl  = PancakeControl(type: .volume, scope: .input,  element: .master)
        let outputMasterVolumeControl = PancakeControl(type: .volume, scope: .output, element: .master)

        pancake.audioObjects.add(inputMasterVolumeControl, outputMasterVolumeControl)
        self.controls = [inputMasterVolumeControl, outputMasterVolumeControl]
    }



    func getProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty {
        printcake(type(of: self), #function, description.selector)

        let scopedSelectors: [PancakeAudioObjectPropertySelector] = [
            .deviceStreams, .deviceCanBeDefaultDevice, .deviceCanBeDefaultSystemDevice, .deviceSafetyOffset, .deviceLatency, .deviceTransportType, .devicePreferredChannelLayout, .deviceNominalSampleRate
        ]
        if description.scope != .global && !scopedSelectors.contains(description.selector) {
            //
        }
        if description.element != .master {

        }

        switch description.selector {

        // Object stuff
        case .objectBaseClass,
            .objectClass,
            .objectManufacturer,
            .objectName,
            .objectOwnedObjects:
            return try self.getObjectProperty(description: description, sizeHint: sizeHint)

        // Device stuff
        case .deviceUID,
             .deviceModelUID,
             .deviceStreams,
             .deviceControlList,
             .deviceNominalSampleRate,
             .deviceAvailableNominalSampleRates,
             .deviceSafetyOffset,
             .deviceLatency,
             .deviceTransportType,
             .deviceIsHidden,
             .deviceCanBeDefaultDevice,
             .deviceCanBeDefaultSystemDevice,
             .deviceConfigurationApplication,
             .devicePreferredChannelLayout,
             .deviceClockDomain,
             .deviceRelatedDevices,
             .deviceIsAlive,
             .deviceIsRunning,
             .deviceIcon,
             .devicePreferredChannelsForStereo:
            return try self.getDeviceProperty(description: description, sizeHint: sizeHint)

        // Device timing stuff
        case .deviceZeroTimeStampPeriod,
             .deviceClockAlgorithm,
             .deviceClockIsStable:
            return try self.getDeviceClockProperty(description: description, sizeHint: sizeHint)

        // Not implemented on purpose
        case .objectModelName,
             .objectElementCategoryName,
             .objectCustomPropertyInfoList,
             .objectListenerAdded,   // Not for applications intended
             .objectListenerRemoved: // Not for applications intended
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)


        default:
            printcake("Not implemented:", description.selector)
            // assertionFailure()
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }


    private func getObjectProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty {
        switch description.selector {
        case .objectBaseClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioObject.classID)

        case .objectClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioDevice.classID)

        case .objectManufacturer:
            try assure(CFString.self, fitsIn: sizeHint)
            return .string(self.configuration.manufacturer as CFString)

        case .objectName:
            try assure(CFString.self, fitsIn: sizeHint)
            return .string(self.configuration.name as CFString)

        case .objectOwnedObjects:
            try assure(AudioObjectID.self, fitsIn: sizeHint)
            let streamIDs  = self.streams.flatMap { $0.objectID }
            let controlIDs = self.controls.flatMap { $0.objectID }
            let ownedObjects = (streamIDs + controlIDs).limitedTo(avaliableMemory: sizeHint)
            return .pancakeObjectIDList(ownedObjects)

        default:
            printcake("Not implemented:", description.selector)
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }

    // swiftlint:disable cyclomatic_complexity function_body_length
    private func getDeviceProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty {
        switch description.selector {
        case .deviceUID:
            try assure(CFString.self, fitsIn: sizeHint)
            return .string(self.configuration.UID as CFString)

        case .deviceModelUID:
            try assure(CFString.self, fitsIn: sizeHint)
            return .string(self.configuration.modelUID as CFString)

        case .deviceStreams:
            try assure(AudioObjectID.self, fitsIn: sizeHint)
            let streamsForScope = self.streams.filter { $0.direction == description.scope }
            let streamIDs = streamsForScope.flatMap { $0.objectID }
            let elements = streamIDs.limitedTo(avaliableMemory: sizeHint)
            return .pancakeObjectIDList(elements)

        case .deviceControlList:
            try assure(AudioObjectID.self, fitsIn: sizeHint)
            let controlIDs = self.controls.flatMap { $0.objectID }
            let elements = controlIDs.limitedTo(avaliableMemory: sizeHint)
            return .pancakeObjectIDList(elements)

        case .deviceNominalSampleRate: // TODO: consider scope
            try assure(Float64.self, fitsIn: sizeHint)
            let sampleRate = self.configuration.registeredFormat.mSampleRate
            return .float64(sampleRate)

        case .deviceAvailableNominalSampleRates:
            try assure(AudioValueRange.self, fitsIn: sizeHint)
            let sampleRateRanges = self.configuration.supportedFormats.map { AudioStreamRangedDescription(asbd: $0).mSampleRateRange }
            return .valueRangeList(sampleRateRanges)

        case .deviceSafetyOffset:
            try assure(UInt32.self, fitsIn: sizeHint)
            let offset = self.configuration.safetyOffsets.value(for: description.scope)
            return .integer(offset)

        case .deviceLatency:
            try assure(UInt32.self, fitsIn: sizeHint)
            let latency = self.configuration.deviceLatency.value(for: description.scope)
            return .integer(latency)

        case .deviceTransportType:
            try assure(UInt32.self, fitsIn: sizeHint)
            return .integer(kAudioDeviceTransportTypeVirtual)

        case .deviceIsHidden:
            try assure(UInt32.self, fitsIn: sizeHint)
            let value = UInt32(self.configuration.hidden)
            return .integer(value)

        case .deviceCanBeDefaultDevice: // TODO: consider scope
            try assure(UInt32.self, fitsIn: sizeHint)
            let value = UInt32(self.configuration.canBeDefaultDevice)
            return .integer(value)

        case .deviceCanBeDefaultSystemDevice: // TODO: consider scope
            try assure(UInt32.self, fitsIn: sizeHint)
            let value = UInt32(self.configuration.canHandleSystemAudio)
            return .integer(value)

        case .devicePreferredChannelLayout: // TODO: consider scope
            try assure(AudioChannelLayout.self, fitsIn: sizeHint)
            let channelCount = self.configuration.registeredFormat.mChannelsPerFrame
            let channelLayout = AudioChannelLayout.linear(channelCount: channelCount)
            return .channelLayout(channelLayout)

        case .deviceRelatedDevices:
            try assure(AudioObjectID.self, fitsIn: sizeHint)
            let allDevices = self.pancake.audioObjects.IDsForObjects(of: PancakeDevice.self)
            let elements = allDevices.limitedTo(avaliableMemory: sizeHint)
            return .pancakeObjectIDList(elements)

        case .deviceIsAlive:
            try assure(UInt32.self, fitsIn: sizeHint)
            return .integer(1) // "I was born ready." -- Terry Benedict

        case .deviceIsRunning:
            try assure(UInt32.self, fitsIn: sizeHint)
            let running = self.IOCount.value > 0
            return .integer(running ? 1 : 0)

        case .deviceIcon:
            try assure(CFURL.self, fitsIn: sizeHint)
            guard let iconURL = self.configuration.iconURL as CFURL? else {
                throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
            }
            return .url(iconURL)

        case .devicePreferredChannelsForStereo:
            try assure(UInt32.self, fitsIn: sizeHint)
            let channels: [UInt32] = [1, 2]
            return .integerList(channels)

        case .deviceConfigurationApplication:
            try assure(CFString.self, fitsIn: sizeHint)
            guard let bundleID = self.configuration.UIAppBundleID as CFString? else {
                throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
            }
            return .string(bundleID)

        case .deviceClockDomain:
            try assure(UInt32.self, fitsIn: sizeHint)
            return .integer(0) // we don't have/know a clock domain


        default:
            printcake("Not implemented:", description.selector)
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }


    // MARK: - Device clock properties
    private func getDeviceClockProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty {
        switch description.selector {
        case .deviceZeroTimeStampPeriod:
            try assure(UInt32.self, fitsIn: sizeHint)
            let ringBufferFrameCount = self.configuration.ringBuffer.frames
            return .integer(ringBufferFrameCount)

        case .deviceClockAlgorithm:
            try assure(AudioDeviceClockAlgorithmSelector.RawValue.self, fitsIn: sizeHint)
            let value = AudioDeviceClockAlgorithmSelector.algorithmSimpleIIR.rawValue
            return .integer(value)

        case .deviceClockIsStable:
            try assure(UInt32.self, fitsIn: sizeHint)
            let value = UInt32(true)
            return .integer(value)

        default:
            printcake("Not implemented:", description.selector)
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }

    func setProperty(description: PancakeObjectPropertyDescription, data: UnsafeRawPointer) throws {
        printcake(type(of: self), #function, description.selector)
        switch description.selector {
//        case .<#pattern#>:


        default:
            printcake("Not implemented:", description.selector)
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
}
