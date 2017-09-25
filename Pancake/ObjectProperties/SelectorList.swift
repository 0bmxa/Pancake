//
//  AudioHardwareBase.swift
//  Pancake
//
//  Created by mxa on 30.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio

// swiftlint:disable identifier_name file_length

enum PancakeAudioObjectID {
    static let unknown = kAudioObjectUnknown
    static let plugin  = kAudioObjectPlugInObject
}


enum PancakeAudioObject {
    static let classID         = kAudioObjectClassID
    static let wildcardClassID = kAudioObjectClassIDWildcard

    enum Selector {
        // AudioHardware.h
        static let creator                = kAudioObjectPropertyCreator
        static let listenerAdded          = kAudioObjectPropertyListenerAdded
        static let listenerRemoved        = kAudioObjectPropertyListenerRemoved

        // AudioHardwareBase.h
        static let baseClass              = kAudioObjectPropertyBaseClass
        static let `class`                = kAudioObjectPropertyClass
        static let owner                  = kAudioObjectPropertyOwner
        static let name                   = kAudioObjectPropertyName
        static let modelName              = kAudioObjectPropertyModelName
        static let manufacturer           = kAudioObjectPropertyManufacturer
        static let elementName            = kAudioObjectPropertyElementName
        static let elementCategoryName    = kAudioObjectPropertyElementCategoryName
        static let elementNumberName      = kAudioObjectPropertyElementNumberName
        static let ownedObjects           = kAudioObjectPropertyOwnedObjects
        static let identify               = kAudioObjectPropertyIdentify
        static let serialNumber           = kAudioObjectPropertySerialNumber
        static let firmwareVersion        = kAudioObjectPropertyFirmwareVersion
        static let wildcard               = kAudioObjectPropertySelectorWildcard

        // AudioServerPlugin.h
        static let customPropertyInfoList = kAudioObjectPropertyCustomPropertyInfoList
    }
}



enum PancakeAudioHardware {
    enum Selector {
        // AudioHardware.h
        static let devices                             = kAudioHardwarePropertyDevices
        static let defaultInputDevice                  = kAudioHardwarePropertyDefaultInputDevice
        static let defaultOutputDevice                 = kAudioHardwarePropertyDefaultOutputDevice
        static let defaultSystemOutputDevice           = kAudioHardwarePropertyDefaultSystemOutputDevice
        static let translateUIDToDevice                = kAudioHardwarePropertyTranslateUIDToDevice
        static let mixStereoToMono                     = kAudioHardwarePropertyMixStereoToMono
        static let pluginList                          = kAudioHardwarePropertyPlugInList
        static let translateBundleIDToPlugin           = kAudioHardwarePropertyTranslateBundleIDToPlugIn
        static let transportManagerList                = kAudioHardwarePropertyTransportManagerList
        static let translateBundleIDToTransportManager = kAudioHardwarePropertyTranslateBundleIDToTransportManager
        static let boxList                             = kAudioHardwarePropertyBoxList
        static let translateUIDToBox                   = kAudioHardwarePropertyTranslateUIDToBox
        static let clockDeviceList                     = kAudioHardwarePropertyClockDeviceList
        static let translateUIDToClockDevice           = kAudioHardwarePropertyTranslateUIDToClockDevice
        static let processIsMaster                     = kAudioHardwarePropertyProcessIsMaster
        static let isInitingOrExiting                  = kAudioHardwarePropertyIsInitingOrExiting
        static let userIDChanged                       = kAudioHardwarePropertyUserIDChanged
        static let processIsAudible                    = kAudioHardwarePropertyProcessIsAudible
        static let sleepingIsAllowed                   = kAudioHardwarePropertySleepingIsAllowed
        static let unloadingIsAllowed                  = kAudioHardwarePropertyUnloadingIsAllowed
        static let hogModeIsAllowed                    = kAudioHardwarePropertyHogModeIsAllowed
        static let userSessionIsActiveOrHeadless       = kAudioHardwarePropertyUserSessionIsActiveOrHeadless
        static let serviceRestarted                    = kAudioHardwarePropertyServiceRestarted
        static let powerHint                           = kAudioHardwarePropertyPowerHint
    }
}



enum PancakeAudioPlugin {
    static let classID: AudioClassID = kAudioPlugInClassID

    enum Selector {
        // AudioHardware.h
        static let createAggregateDevice  = kAudioPlugInCreateAggregateDevice
        static let destroyAggregateDevice = kAudioPlugInDestroyAggregateDevice

        // AudioHardwareBase.h
        static let bundleID                  = kAudioPlugInPropertyBundleID
        static let deviceList                = kAudioPlugInPropertyDeviceList
        static let translateUIDToDevice      = kAudioPlugInPropertyTranslateUIDToDevice
        static let boxList                   = kAudioPlugInPropertyBoxList
        static let translateUIDToBox         = kAudioPlugInPropertyTranslateUIDToBox
        static let clockDeviceList           = kAudioPlugInPropertyClockDeviceList
        static let translateUIDToClockDevice = kAudioPlugInPropertyTranslateUIDToClockDevice

        // AudioServerPlugin.h
        static let resourceBundle            = kAudioPlugInPropertyResourceBundle
    }
}


enum PancakeAudioAggregateDevice {
    enum Selector {
        // AudioHardware.h
        static let fullSubDeviceList   = kAudioAggregateDevicePropertyFullSubDeviceList
        static let activeSubDeviceList = kAudioAggregateDevicePropertyActiveSubDeviceList
        static let composition         = kAudioAggregateDevicePropertyComposition
        static let masterSubDevice     = kAudioAggregateDevicePropertyMasterSubDevice
        static let clockDevice         = kAudioAggregateDevicePropertyClockDevice
    }
}


enum PancakeAudioSubDevice {
    enum Selector {
        // AudioHardware.h
        static let extraLatency             = kAudioSubDevicePropertyExtraLatency
        static let driftCompensation        = kAudioSubDevicePropertyDriftCompensation
        static let driftCompensationQuality = kAudioSubDevicePropertyDriftCompensationQuality
    }
}


enum PancakeAudioTransportManager {
    static let classID: AudioClassID = kAudioTransportManagerClassID

    enum Selector {
        // AudioHardware.h
        static let createEndPointDevice  = kAudioTransportManagerCreateEndPointDevice
        static let destroyEndPointDevice = kAudioTransportManagerDestroyEndPointDevice

        // AudioHardwareBase.h
        static let endPointList           = kAudioTransportManagerPropertyEndPointList
        static let translateUIDToEndPoint = kAudioTransportManagerPropertyTranslateUIDToEndPoint

        /*
         The following are disable on purpose, because they use the same
         values as the coresponding PancakeAudioDevice properties
         and therefore cause a Swift pattern matching collision 🙄
         static let transportType          = kAudioTransportManagerPropertyTransportType
         */
    }
}


enum PancakeAudioBox {
    static let classID: AudioClassID = kAudioBoxClassID

    enum Selector {
        // AudioHardwareBase.h
        static let UID               = kAudioBoxPropertyBoxUID
        static let hasAudio          = kAudioBoxPropertyHasAudio
        static let hasVideo          = kAudioBoxPropertyHasVideo
        static let hasMIDI           = kAudioBoxPropertyHasMIDI
        static let isProtected       = kAudioBoxPropertyIsProtected
        static let acquired          = kAudioBoxPropertyAcquired
        static let acquisitionFailed = kAudioBoxPropertyAcquisitionFailed
        static let deviceList        = kAudioBoxPropertyDeviceList
        static let clockDeviceList   = kAudioBoxPropertyClockDeviceList

        /*
         The following are disable on purpose, because they use the same
         values as the coresponding PancakeAudioDevice properties
         and therefore cause a Swift pattern matching collision 🙄
         static let transportType     = kAudioBoxPropertyTransportType
         */
    }
}



enum PancakeAudioDevice {
    static let classID: AudioClassID = kAudioDeviceClassID

    enum Selector {
        // AudioHardware.h
        static let plugin                       = kAudioDevicePropertyPlugIn
        static let hasChanged                   = kAudioDevicePropertyDeviceHasChanged
        static let isRunningSomewhere           = kAudioDevicePropertyDeviceIsRunningSomewhere
        static let processorOverload            = kAudioDeviceProcessorOverload // 🙄
        static let IOStoppedAbnormally          = kAudioDevicePropertyIOStoppedAbnormally
        static let hogMode                      = kAudioDevicePropertyHogMode
        static let bufferFrameSize              = kAudioDevicePropertyBufferFrameSize
        static let bufferFrameSizeRange         = kAudioDevicePropertyBufferFrameSizeRange
        static let usesVariableBufferFrameSizes = kAudioDevicePropertyUsesVariableBufferFrameSizes
        static let IOCycleUsage                 = kAudioDevicePropertyIOCycleUsage
        static let streamConfiguration          = kAudioDevicePropertyStreamConfiguration
        static let IOProcStreamUsage            = kAudioDevicePropertyIOProcStreamUsage
        static let actualSampleRate             = kAudioDevicePropertyActualSampleRate
        static let clockDevice                  = kAudioDevicePropertyClockDevice

        static let jackIsConnected                          = kAudioDevicePropertyJackIsConnected
        static let volumeScalar                             = kAudioDevicePropertyVolumeScalar
        static let volumeDecibels                           = kAudioDevicePropertyVolumeDecibels
        static let volumeRangeDecibels                      = kAudioDevicePropertyVolumeRangeDecibels
        static let volumeScalarToDecibels                   = kAudioDevicePropertyVolumeScalarToDecibels
        static let volumeDecibelsToScalar                   = kAudioDevicePropertyVolumeDecibelsToScalar
        static let stereoPan                                = kAudioDevicePropertyStereoPan
        static let stereoPanChannels                        = kAudioDevicePropertyStereoPanChannels
        static let mute                                     = kAudioDevicePropertyMute
        static let solo                                     = kAudioDevicePropertySolo
        static let phantomPower                             = kAudioDevicePropertyPhantomPower
        static let phaseInvert                              = kAudioDevicePropertyPhaseInvert
        static let clipLight                                = kAudioDevicePropertyClipLight
        static let talkback                                 = kAudioDevicePropertyTalkback
        static let listenback                               = kAudioDevicePropertyListenback
        static let dataSource                               = kAudioDevicePropertyDataSource
        static let dataSources                              = kAudioDevicePropertyDataSources
        static let dataSourceNameForIDCFString              = kAudioDevicePropertyDataSourceNameForIDCFString
        static let dataSourceKindForID                      = kAudioDevicePropertyDataSourceKindForID
        static let clockSource                              = kAudioDevicePropertyClockSource
        static let clockSources                             = kAudioDevicePropertyClockSources
        static let clockSourceNameForIDCFString             = kAudioDevicePropertyClockSourceNameForIDCFString
        static let clockSourceKindForID                     = kAudioDevicePropertyClockSourceKindForID
        static let playThru                                 = kAudioDevicePropertyPlayThru
        static let playThruSolo                             = kAudioDevicePropertyPlayThruSolo
        static let playThruVolumeScalar                     = kAudioDevicePropertyPlayThruVolumeScalar
        static let playThruVolumeDecibels                   = kAudioDevicePropertyPlayThruVolumeDecibels
        static let playThruVolumeRangeDecibels              = kAudioDevicePropertyPlayThruVolumeRangeDecibels
        static let playThruVolumeScalarToDecibels           = kAudioDevicePropertyPlayThruVolumeScalarToDecibels
        static let playThruVolumeDecibelsToScalar           = kAudioDevicePropertyPlayThruVolumeDecibelsToScalar
        static let playThruStereoPan                        = kAudioDevicePropertyPlayThruStereoPan
        static let playThruStereoPanChannels                = kAudioDevicePropertyPlayThruStereoPanChannels
        static let playThruDestination                      = kAudioDevicePropertyPlayThruDestination
        static let playThruDestinations                     = kAudioDevicePropertyPlayThruDestinations
        static let playThruDestinationNameForIDCFString     = kAudioDevicePropertyPlayThruDestinationNameForIDCFString
        static let channelNominalLineLevel                  = kAudioDevicePropertyChannelNominalLineLevel
        static let channelNominalLineLevels                 = kAudioDevicePropertyChannelNominalLineLevels
        static let channelNominalLineLevelNameForIDCFString = kAudioDevicePropertyChannelNominalLineLevelNameForIDCFString
        static let highPassFilterSetting                    = kAudioDevicePropertyHighPassFilterSetting
        static let highPassFilterSettings                   = kAudioDevicePropertyHighPassFilterSettings
        static let highPassFilterSettingNameForIDCFString   = kAudioDevicePropertyHighPassFilterSettingNameForIDCFString
        static let subVolumeScalar                          = kAudioDevicePropertySubVolumeScalar
        static let subVolumeDecibels                        = kAudioDevicePropertySubVolumeDecibels
        static let subVolumeRangeDecibels                   = kAudioDevicePropertySubVolumeRangeDecibels
        static let subVolumeScalarToDecibels                = kAudioDevicePropertySubVolumeScalarToDecibels
        static let subVolumeDecibelsToScalar                = kAudioDevicePropertySubVolumeDecibelsToScalar
        static let subMute                                  = kAudioDevicePropertySubMute

        // AudioHardwareBase.h
        static let configurationApplication       = kAudioDevicePropertyConfigurationApplication
        static let UID                            = kAudioDevicePropertyDeviceUID
        static let modelUID                       = kAudioDevicePropertyModelUID
        static let transportType                  = kAudioDevicePropertyTransportType
        static let relatedDevices                 = kAudioDevicePropertyRelatedDevices
        static let clockDomain                    = kAudioDevicePropertyClockDomain
        static let isAlive                        = kAudioDevicePropertyDeviceIsAlive
        static let isRunning                      = kAudioDevicePropertyDeviceIsRunning
        static let canBeDefaultDevice             = kAudioDevicePropertyDeviceCanBeDefaultDevice
        static let canBeDefaultSystemDevice       = kAudioDevicePropertyDeviceCanBeDefaultSystemDevice
        static let latency                        = kAudioDevicePropertyLatency
        static let streams                        = kAudioDevicePropertyStreams
        static let controlList                    = kAudioObjectPropertyControlList // 🙄
        static let safetyOffset                   = kAudioDevicePropertySafetyOffset
        static let nominalSampleRate              = kAudioDevicePropertyNominalSampleRate
        static let availableNominalSampleRates    = kAudioDevicePropertyAvailableNominalSampleRates
        static let icon                           = kAudioDevicePropertyIcon
        static let isHidden                       = kAudioDevicePropertyIsHidden
        static let preferredChannelsForStereo     = kAudioDevicePropertyPreferredChannelsForStereo
        static let preferredChannelLayout         = kAudioDevicePropertyPreferredChannelLayout

        // AudioServerPlugin.h
        static let zeroTimeStampPeriod            = kAudioDevicePropertyZeroTimeStampPeriod
        static let clockAlgorithm                 = kAudioDevicePropertyClockAlgorithm
        static let clockIsStable                  = kAudioDevicePropertyClockIsStable

    }
}



enum PancakeAudioClockDevice {
    static let classID: AudioClassID = kAudioClockDeviceClassID

    enum Selector {
        // AudioHardwareBase.h
        static let UID                         = kAudioClockDevicePropertyDeviceUID

        /*
         The following are disable on purpose, because they use the same
         values as the coresponding PancakeAudioDevice properties
         and therefore cause a Swift pattern matching collision 🙄
         static let transportType               = kAudioClockDevicePropertyTransportType
         static let clockDomain                 = kAudioClockDevicePropertyClockDomain
         static let isAlive                     = kAudioClockDevicePropertyDeviceIsAlive
         static let isRunning                   = kAudioClockDevicePropertyDeviceIsRunning
         static let latency                     = kAudioClockDevicePropertyLatency
         static let controlList                 = kAudioClockDevicePropertyControlList
         static let nominalSampleRate           = kAudioClockDevicePropertyNominalSampleRate
         static let availableNominalSampleRates = kAudioClockDevicePropertyAvailableNominalSampleRates
         */
    }
}



enum PancakeAudioEndPointDevice {
    static let classID: AudioClassID = kAudioEndPointDeviceClassID

    enum Selector {
        // AudioHardwareBase.h
        static let composition  = kAudioEndPointDevicePropertyComposition
        static let endPointList = kAudioEndPointDevicePropertyEndPointList
        static let isPrivate    = kAudioEndPointDevicePropertyIsPrivate
    }
}



enum PancakeAudioEndPoint {
    static let classID: AudioClassID = kAudioEndPointClassID
}



enum PancakeAudioStream {
    static let classID: AudioClassID = kAudioStreamClassID

    enum Selector {
        // AudioHardwareBase.h
        static let isActive                 = kAudioStreamPropertyIsActive
        static let direction                = kAudioStreamPropertyDirection
        static let terminalType             = kAudioStreamPropertyTerminalType
        static let startingChannel          = kAudioStreamPropertyStartingChannel
        static let latency                  = kAudioStreamPropertyLatency
        static let virtualFormat            = kAudioStreamPropertyVirtualFormat
        static let availableVirtualFormats  = kAudioStreamPropertyAvailableVirtualFormats
        static let physicalFormat           = kAudioStreamPropertyPhysicalFormat
        static let availablePhysicalFormats = kAudioStreamPropertyAvailablePhysicalFormats
    }
}



enum PancakeAudioControl {
    // The generic control class ID
    static let classID: AudioClassID = kAudioControlClassID

    enum Selector {
        // AudioHardwareBase.h
        static let scope   = kAudioControlPropertyScope
        static let element = kAudioControlPropertyElement
    }

    // Control types
    case mute
    case solo
    case jack
    case LFEMute
    case phantomPower
    case phaseInvert
    case clipLight
    case talkback
    case listenback
    case dataSource
    case dataDestination
    case clockSource
    case lineLevel
    case highPassFilter
    case volume
    case LFEVolume

    case slider
    case level
    case boolean
    case selector
    case stereoPan

    var classID: AudioClassID {
        switch self {
        case .mute:            return kAudioMuteControlClassID
        case .solo:            return kAudioSoloControlClassID
        case .jack:            return kAudioJackControlClassID
        case .LFEMute:         return kAudioLFEMuteControlClassID
        case .phantomPower:    return kAudioPhantomPowerControlClassID
        case .phaseInvert:     return kAudioPhaseInvertControlClassID
        case .clipLight:       return kAudioClipLightControlClassID
        case .talkback:        return kAudioTalkbackControlClassID
        case .listenback:      return kAudioListenbackControlClassID
        case .dataSource:      return kAudioDataSourceControlClassID
        case .dataDestination: return kAudioDataDestinationControlClassID
        case .clockSource:     return kAudioClockSourceControlClassID
        case .lineLevel:       return kAudioLineLevelControlClassID
        case .highPassFilter:  return kAudioHighPassFilterControlClassID
        case .volume:          return kAudioVolumeControlClassID
        case .LFEVolume:       return kAudioLFEVolumeControlClassID
        case .slider:          return PancakeAudioSliderControl.classID
        case .level:           return PancakeAudioLevelControl.classID
        case .boolean:         return PancakeAudioBooleanControl.classID
        case .selector:        return PancakeAudioSelectorControl.classID
        case .stereoPan:       return PancakeAudioStereoPanControl.classID
        }
    }
}


enum PancakeAudioSliderControl {
    static let classID: AudioClassID = kAudioSliderControlClassID

    enum Selector {
        // AudioHardwareBase.h
        static let value = kAudioSliderControlPropertyValue
        static let range = kAudioSliderControlPropertyRange
    }
}


enum PancakeAudioLevelControl {
    static let classID: AudioClassID = kAudioLevelControlClassID

    enum Selector {
        // AudioHardwareBase.h
        static let scalarValue             = kAudioLevelControlPropertyScalarValue
        static let decibelValue            = kAudioLevelControlPropertyDecibelValue
        static let decibelRange            = kAudioLevelControlPropertyDecibelRange
        static let convertScalarToDecibels = kAudioLevelControlPropertyConvertScalarToDecibels
        static let convertDecibelsToScalar = kAudioLevelControlPropertyConvertDecibelsToScalar
    }
}


enum PancakeAudioBooleanControl {
    static let classID: AudioClassID = kAudioBooleanControlClassID

    enum Selector {
        // AudioHardwareBase.h
        static let value = kAudioBooleanControlPropertyValue
    }
}


enum PancakeAudioSelectorControl {
    static let classID: AudioClassID = kAudioSelectorControlClassID

    enum Selector {
        // AudioHardwareBase.h
        static let currentItem    = kAudioSelectorControlPropertyCurrentItem
        static let availableItems = kAudioSelectorControlPropertyAvailableItems
        static let itemName       = kAudioSelectorControlPropertyItemName
        static let itemKind       = kAudioSelectorControlPropertyItemKind
    }
}


enum PancakeAudioStereoPanControl {
    static let classID: AudioClassID = kAudioStereoPanControlClassID

    enum Selector {
        // AudioHardwareBase.h
        static let value           = kAudioStereoPanControlPropertyValue
        static let panningChannels = kAudioStereoPanControlPropertyPanningChannels
    }
}



// MARK: - Stuff from AudioHardwareDeprecated.h

@available(*, deprecated)
extension PancakeAudioObjectID {
    static let deviceUnknown = PancakeAudioObjectID.unknown
    static let streamUnknown = PancakeAudioObjectID.unknown
}

@available(*, deprecated)
extension PancakeAudioLevelControl.Selector {
    static let decibelsToScalarTransferFunction = kAudioLevelControlPropertyDecibelsToScalarTransferFunction
}

@available(*, deprecated)
extension PancakeAudioHardware.Selector {
    static let runLoop           = kAudioHardwarePropertyRunLoop
    static let deviceForUID      = kAudioHardwarePropertyDeviceForUID
    static let pluginForBundleID = kAudioHardwarePropertyPlugInForBundleID

    static let bootChimeVolumeScalar                           = kAudioHardwarePropertyBootChimeVolumeScalar
    static let bootChimeVolumeDecibels                         = kAudioHardwarePropertyBootChimeVolumeDecibels
    static let bootChimeVolumeRangeDecibels                    = kAudioHardwarePropertyBootChimeVolumeRangeDecibels
    static let bootChimeVolumeScalarToDecibels                 = kAudioHardwarePropertyBootChimeVolumeScalarToDecibels
    static let bootChimeVolumeDecibelsToScalar                 = kAudioHardwarePropertyBootChimeVolumeDecibelsToScalar
    static let bootChimeVolumeDecibelsToScalarTransferFunction = kAudioHardwarePropertyBootChimeVolumeDecibelsToScalarTransferFunction
}

@available(*, deprecated)
extension PancakeAudioDevice.Selector {
    static let volumeDecibelsToScalarTransferFunction         = kAudioDevicePropertyVolumeDecibelsToScalarTransferFunction
    static let playThruVolumeDecibelsToScalarTransferFunction = kAudioDevicePropertyPlayThruVolumeDecibelsToScalarTransferFunction
    static let driverShouldOwniSub                            = kAudioDevicePropertyDriverShouldOwniSub
    static let subVolumeDecibelsToScalarTransferFunction      = kAudioDevicePropertySubVolumeDecibelsToScalarTransferFunction

    static let deviceName                       = kAudioDevicePropertyDeviceName
    static let deviceManufacturer               = kAudioDevicePropertyDeviceManufacturer
    static let registerBufferList               = kAudioDevicePropertyRegisterBufferList
    static let bufferSize                       = kAudioDevicePropertyBufferSize
    static let bufferSizeRange                  = kAudioDevicePropertyBufferSizeRange
    static let channelName                      = kAudioDevicePropertyChannelName
    static let channelCategoryName              = kAudioDevicePropertyChannelCategoryName
    static let channelNumberName                = kAudioDevicePropertyChannelNumberName
    static let supportsMixing                   = kAudioDevicePropertySupportsMixing
    static let streamFormat                     = kAudioDevicePropertyStreamFormat
    static let streamFormats                    = kAudioDevicePropertyStreamFormats
    static let streamFormatSupported            = kAudioDevicePropertyStreamFormatSupported
    static let streamFormatMatch                = kAudioDevicePropertyStreamFormatMatch
    static let dataSourceNameForID              = kAudioDevicePropertyDataSourceNameForID
    static let clockSourceNameForID             = kAudioDevicePropertyClockSourceNameForID
    static let playThruDestinationNameForID     = kAudioDevicePropertyPlayThruDestinationNameForID
    static let channelNominalLineLevelNameForID = kAudioDevicePropertyChannelNominalLineLevelNameForID
    static let highPassFilterSettingNameForID   = kAudioDevicePropertyHighPassFilterSettingNameForID
}

@available(*, deprecated)
extension PancakeAudioStream.Selector {
    static let physicalFormats         = kAudioStreamPropertyPhysicalFormats
    static let physicalFormatSupported = kAudioStreamPropertyPhysicalFormatSupported
    static let physicalFormatMatch     = kAudioStreamPropertyPhysicalFormatMatch
    static let owningDevice            = PancakeAudioObject.Selector.owner
}

@available(*, deprecated)
extension PancakeAudioControl.Selector {
    static let variant = kAudioControlPropertyVariant
}

@available(*, deprecated)
enum PancakeAudio {
    enum Selector {
        static let wildcardPropertyID = PancakeAudioObject.Selector.wildcard
    }
}

@available(*, deprecated)
enum PancakeAudioClockSourceControl {
    enum Selector {
        static let itemKind = PancakeAudioSelectorControl.Selector.itemKind
    }
}
