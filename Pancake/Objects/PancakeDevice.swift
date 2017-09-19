//
//  PancakeDevice.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

class PancakeDevice: PancakeObjectType {
    internal var objectID: AudioObjectID? = nil

    private let pancake: Pancake
    internal let configuration: DeviceConfiguration
    private var controls: [PancakeControl]
    private let streams: [PancakeStream]
    
    required convenience init(pancake: Pancake) {
        fatalError()
    }

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
        
        switch description.selector {
        case .objectBaseClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioObject.classID)
            
        case .objectClass:
            try assure(AudioClassID.self, fitsIn: sizeHint)
            return .audioClassID(PancakeAudioDevice.classID)
            
        case .deviceUID:
            try assure(CFString.self, fitsIn: sizeHint)
            return .string(self.configuration.uid as CFString)
            
        case .deviceStreams:
            try assure(AudioObjectID.self, fitsIn: sizeHint)
            let streamIDs = self.streams.flatMap { $0.objectID }
            let elements = streamIDs.limitedTo(avaliableMemory: sizeHint)
            return .pancakeObjectIDList(elements)
            
        case .deviceControlList:
            try assure(AudioObjectID.self, fitsIn: sizeHint)
            let controlIDs = self.controls.flatMap { $0.objectID }
            let elements = controlIDs.limitedTo(avaliableMemory: sizeHint)
            return .pancakeObjectIDList(elements)
            
        case .deviceNominalSampleRate:
            try assure(Float64.self, fitsIn: sizeHint)
            let sampleRate = self.configuration.registeredFormat.mSampleRate
            return .float(sampleRate)
            
        case .deviceAvailableNominalSampleRates:
            try assure(AudioValueRange.self, fitsIn: sizeHint)
            let sampleRateRanges = self.configuration.supportedFormats.map { AudioStreamRangedDescription(asbd: $0).mSampleRateRange }
            return .valueRangeList(sampleRateRanges)
            
        case .deviceZeroTimeStampPeriod:
            try assure(UInt32.self, fitsIn: sizeHint)
            let ringBufferSize = self.configuration.ringBuffer.size
            return .integer(ringBufferSize)
            
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
            
        case .deviceCanBeDefaultDevice:
            try assure(UInt32.self, fitsIn: sizeHint)
            let value = UInt32(self.configuration.canBeDefaultDevice)
            return .integer(value)

        case .deviceCanBeDefaultSystemDevice:
            try assure(UInt32.self, fitsIn: sizeHint)
            let value = UInt32(self.configuration.canHandleSystemAudio)
            return .integer(value)


// =============================================================================
//  AudioHub
        case .objectName: fatalError()
        case .objectManufacturer: fatalError()
        case .objectOwnedObjects: fatalError()
        case .deviceModelUID: fatalError()
        case .deviceRelatedDevices: fatalError()
        case .deviceClockDomain: fatalError()
        case .deviceIsAlive: fatalError()
        case .deviceIsRunning: fatalError()
        case .deviceIcon: fatalError()
        case .devicePreferredChannelsForStereo: fatalError()
        case .devicePreferredChannelLayout: fatalError()
// =============================================================================
// Available
        case .devicePlugin: fatalError()
        case .deviceHasChanged: fatalError()
        case .deviceIsRunningSomewhere: fatalError()
        case .deviceProcessorOverload: fatalError()
        case .deviceIOStoppedAbnormally: fatalError()
        case .deviceHogMode: fatalError()
        case .deviceBufferFrameSize: fatalError()
        case .deviceBufferFrameSizeRange: fatalError()
        case .deviceUsesVariableBufferFrameSizes: fatalError()
        case .deviceIOCycleUsage: fatalError()
        case .deviceStreamConfiguration: fatalError()
        case .deviceIOProcStreamUsage: fatalError()
        case .deviceActualSampleRate: fatalError()
        case .deviceClockDevice: fatalError()
        case .deviceJackIsConnected: fatalError()
        case .deviceVolumeScalar: fatalError()
        case .deviceVolumeDecibels: fatalError()
        case .deviceVolumeRangeDecibels: fatalError()
        case .deviceVolumeScalarToDecibels: fatalError()
        case .deviceVolumeDecibelsToScalar: fatalError()
        case .deviceStereoPan: fatalError()
        case .deviceStereoPanChannels: fatalError()
        case .deviceMute: fatalError()
        case .deviceSolo: fatalError()
        case .devicePhantomPower: fatalError()
        case .devicePhaseInvert: fatalError()
        case .deviceClipLight: fatalError()
        case .deviceTalkback: fatalError()
        case .deviceListenback: fatalError()
        case .deviceDataSource: fatalError()
        case .deviceDataSources: fatalError()
        case .deviceDataSourceNameForIDCFString: fatalError()
        case .deviceDataSourceKindForID: fatalError()
        case .deviceClockSource: fatalError()
        case .deviceClockSources: fatalError()
        case .deviceClockSourceNameForIDCFString: fatalError()
        case .deviceClockSourceKindForID: fatalError()
        case .devicePlayThru: fatalError()
        case .devicePlayThruSolo: fatalError()
        case .devicePlayThruVolumeScalar: fatalError()
        case .devicePlayThruVolumeDecibels: fatalError()
        case .devicePlayThruVolumeRangeDecibels: fatalError()
        case .devicePlayThruVolumeScalarToDecibels: fatalError()
        case .devicePlayThruVolumeDecibelsToScalar: fatalError()
        case .devicePlayThruStereoPan: fatalError()
        case .devicePlayThruStereoPanChannels: fatalError()
        case .devicePlayThruDestination: fatalError()
        case .devicePlayThruDestinations: fatalError()
        case .devicePlayThruDestinationNameForIDCFString: fatalError()
        case .deviceChannelNominalLineLevel: fatalError()
        case .deviceChannelNominalLineLevels: fatalError()
        case .deviceChannelNominalLineLevelNameForIDCFString: fatalError()
        case .deviceHighPassFilterSetting: fatalError()
        case .deviceHighPassFilterSettings: fatalError()
        case .deviceHighPassFilterSettingNameForIDCFString: fatalError()
        case .deviceSubVolumeScalar: fatalError()
        case .deviceSubVolumeDecibels: fatalError()
        case .deviceSubVolumeRangeDecibels: fatalError()
        case .deviceSubVolumeScalarToDecibels: fatalError()
        case .deviceSubVolumeDecibelsToScalar: fatalError()
        case .deviceSubMute: fatalError()
        case .deviceConfigurationApplication: fatalError()
            
        case .deviceClockAlgorithm: fallthrough
        case .deviceClockIsStable: fallthrough
// =============================================================================

        default:
            printcake("Not implemented:", description.selector)
            // assertionFailure()
            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
        }
    }
}

