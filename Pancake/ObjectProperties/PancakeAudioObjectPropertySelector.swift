//
//  PancakeAudioObjectPropertySelector.swift
//  Pancake
//
//  Created by mxa on 31.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio


enum PancakeAudioObjectPropertySelector {
    // Object
    case objectCreator
    case objectListenerAdded
    case objectListenerRemoved
    case objectBaseClass
    case objectClass
    case objectOwner
    case objectName
    case objectModelName
    case objectManufacturer
    case objectElementName
    case objectElementCategoryName
    case objectElementNumberName
    case objectOwnedObjects
    case objectIdentify
    case objectSerialNumber
    case objectFirmwareVersion
    case objectWildcard
    case objectCustomPropertyInfoList
    
    // Hardware
    case hardwareDevices
    case hardwareDefaultInputDevice
    case hardwareDefaultOutputDevice
    case hardwareDefaultSystemOutputDevice
    case hardwareTranslateUIDToDevice
    case hardwareMixStereoToMono
    case hardwarePluginList
    case hardwareTranslateBundleIDToPlugin
    case hardwareTransportManagerList
    case hardwareTranslateBundleIDToTransportManager
    case hardwareBoxList
    case hardwareTranslateUIDToBox
    case hardwareClockDeviceList
    case hardwareTranslateUIDToClockDevice
    case hardwareProcessIsMaster
    case hardwareIsInitingOrExiting
    case hardwareUserIDChanged
    case hardwareProcessIsAudible
    case hardwareSleepingIsAllowed
    case hardwareUnloadingIsAllowed
    case hardwareHogModeIsAllowed
    case hardwareUserSessionIsActiveOrHeadless
    case hardwareServiceRestarted
    case hardwarePowerHint
    
    // Plugin
    case pluginCreateAggregateDevice
    case pluginDestroyAggregateDevice
    case pluginBundleID
    case pluginDeviceList
    case pluginTranslateUIDToDevice
    case pluginBoxList
    case pluginTranslateUIDToBox
    case pluginClockDeviceList
    case pluginTranslateUIDToClockDevice
    case pluginResourceBundle
    
    // AggregateDevice
    case aggregateDeviceFullSubDeviceList
    case aggregateDeviceActiveSubDeviceList
    case aggregateDeviceComposition
    case aggregateDeviceMasterSubDevice
    case aggregateDeviceClockDevice
    
    // SubDevice
    case subDeviceExtraLatency
    case subDeviceDriftCompensation
    case subDeviceDriftCompensationQuality
    
    // TransportManager
    case transportManagerCreateEndPointDevice
    case transportManagerDestroyEndPointDevice
    case transportManagerEndPointList
    case transportManagerTranslateUIDToEndPoint
    /*
     See SelectorList.swift for explanation
     case transportManagerTransportType
     */
    
    // Box
    case boxUID
    /*
    See SelectorList.swift for explanation
    case boxTransportType
    */
    case boxHasAudio
    case boxHasVideo
    case boxHasMIDI
    case boxIsProtected
    case boxAcquired
    case boxAcquisitionFailed
    case boxDeviceList
    case boxClockDeviceList
    
    // Device
    case devicePlugin
    case deviceHasChanged
    case deviceIsRunningSomewhere
    case deviceProcessorOverload
    case deviceIOStoppedAbnormally
    case deviceHogMode
    case deviceBufferFrameSize
    case deviceBufferFrameSizeRange
    case deviceUsesVariableBufferFrameSizes
    case deviceIOCycleUsage
    case deviceStreamConfiguration
    case deviceIOProcStreamUsage
    case deviceActualSampleRate
    case deviceClockDevice
    case deviceJackIsConnected
    case deviceVolumeScalar
    case deviceVolumeDecibels
    case deviceVolumeRangeDecibels
    case deviceVolumeScalarToDecibels
    case deviceVolumeDecibelsToScalar
    case deviceStereoPan
    case deviceStereoPanChannels
    case deviceMute
    case deviceSolo
    case devicePhantomPower
    case devicePhaseInvert
    case deviceClipLight
    case deviceTalkback
    case deviceListenback
    case deviceDataSource
    case deviceDataSources
    case deviceDataSourceNameForIDCFString
    case deviceDataSourceKindForID
    case deviceClockSource
    case deviceClockSources
    case deviceClockSourceNameForIDCFString
    case deviceClockSourceKindForID
    case devicePlayThru
    case devicePlayThruSolo
    case devicePlayThruVolumeScalar
    case devicePlayThruVolumeDecibels
    case devicePlayThruVolumeRangeDecibels
    case devicePlayThruVolumeScalarToDecibels
    case devicePlayThruVolumeDecibelsToScalar
    case devicePlayThruStereoPan
    case devicePlayThruStereoPanChannels
    case devicePlayThruDestination
    case devicePlayThruDestinations
    case devicePlayThruDestinationNameForIDCFString
    case deviceChannelNominalLineLevel
    case deviceChannelNominalLineLevels
    case deviceChannelNominalLineLevelNameForIDCFString
    case deviceHighPassFilterSetting
    case deviceHighPassFilterSettings
    case deviceHighPassFilterSettingNameForIDCFString
    case deviceSubVolumeScalar
    case deviceSubVolumeDecibels
    case deviceSubVolumeRangeDecibels
    case deviceSubVolumeScalarToDecibels
    case deviceSubVolumeDecibelsToScalar
    case deviceSubMute
    case deviceConfigurationApplication
    case deviceUID
    case deviceModelUID
    case deviceTransportType
    case deviceRelatedDevices
    case deviceClockDomain
    case deviceIsAlive
    case deviceIsRunning
    case deviceCanBeDefaultDevice
    case deviceCanBeDefaultSystemDevice
    case deviceLatency
    case deviceStreams
    case deviceControlList
    case deviceSafetyOffset
    case deviceNominalSampleRate
    case deviceAvailableNominalSampleRates
    case deviceIcon
    case deviceIsHidden
    case devicePreferredChannelsForStereo
    case devicePreferredChannelLayout
    case deviceZeroTimeStampPeriod
    case deviceClockAlgorithm
    case deviceClockIsStable
    
    // ClockDevice
    case clockDeviceUID
    /*
     See SelectorList.swift for explanation
     case clockDeviceTransportType
     case clockDeviceClockDomain
     case clockDeviceIsAlive
     case clockDeviceIsRunning
     case clockDeviceLatency
     case clockDeviceControlList
     case clockDeviceNominalSampleRate
     case clockDeviceAvailableNominalSampleRates
     */

    // EndPointDevice
    case endPointDeviceComposition
    case endPointDeviceEndPointList
    case endPointDeviceIsPrivate
    
    // Stream
    case streamIsActive
    case streamDirection
    case streamTerminalType
    case streamStartingChannel
    case streamLatency
    case streamVirtualFormat
    case streamAvailableVirtualFormats
    case streamPhysicalFormat
    case streamAvailablePhysicalFormats
    
    // Control
    case controlScope
    case controlElement
    
    // SliderControl
    case sliderControlValue
    case sliderControlRange
    
    // LevelControl
    case levelControlScalarValue
    case levelControlDecibelValue
    case levelControlDecibelRange
    case levelControlConvertScalarToDecibels
    case levelControlConvertDecibelsToScalar
    
    // BooleanControl
    case booleanControlValue
    
    // SelectorControl
    case selectorControlCurrentItem
    case selectorControlAvailableItems
    case selectorControlItemName
    case selectorControlItemKind
    
    // StereoPanControl
    case stereoPanControlValue
    case stereoPanControlPanningChannels
}



// MARK: - RawRepresentable

extension PancakeAudioObjectPropertySelector: RawRepresentable {
    public init?(rawValue: AudioObjectPropertySelector) {
        switch rawValue {
        // Object
        case PancakeAudioObject.Selector.creator:                                  self = .objectCreator
        case PancakeAudioObject.Selector.listenerAdded:                            self = .objectListenerAdded
        case PancakeAudioObject.Selector.listenerRemoved:                          self = .objectListenerRemoved
        case PancakeAudioObject.Selector.baseClass:                                self = .objectBaseClass
        case PancakeAudioObject.Selector.class:                                    self = .objectClass
        case PancakeAudioObject.Selector.owner:                                    self = .objectOwner
        case PancakeAudioObject.Selector.name:                                     self = .objectName
        case PancakeAudioObject.Selector.modelName:                                self = .objectModelName
        case PancakeAudioObject.Selector.manufacturer:                             self = .objectManufacturer
        case PancakeAudioObject.Selector.elementName:                              self = .objectElementName
        case PancakeAudioObject.Selector.elementCategoryName:                      self = .objectElementCategoryName
        case PancakeAudioObject.Selector.elementNumberName:                        self = .objectElementNumberName
        case PancakeAudioObject.Selector.ownedObjects:                             self = .objectOwnedObjects
        case PancakeAudioObject.Selector.identify:                                 self = .objectIdentify
        case PancakeAudioObject.Selector.serialNumber:                             self = .objectSerialNumber
        case PancakeAudioObject.Selector.firmwareVersion:                          self = .objectFirmwareVersion
        case PancakeAudioObject.Selector.wildcard:                                 self = .objectWildcard
        case PancakeAudioObject.Selector.customPropertyInfoList:                   self = .objectCustomPropertyInfoList
            
        // Hardware
        case PancakeAudioHardware.Selector.devices:                                self = .hardwareDevices
        case PancakeAudioHardware.Selector.defaultInputDevice:                     self = .hardwareDefaultInputDevice
        case PancakeAudioHardware.Selector.defaultOutputDevice:                    self = .hardwareDefaultOutputDevice
        case PancakeAudioHardware.Selector.defaultSystemOutputDevice:              self = .hardwareDefaultSystemOutputDevice
        case PancakeAudioHardware.Selector.translateUIDToDevice:                   self = .hardwareTranslateUIDToDevice
        case PancakeAudioHardware.Selector.mixStereoToMono:                        self = .hardwareMixStereoToMono
        case PancakeAudioHardware.Selector.pluginList:                             self = .hardwarePluginList
        case PancakeAudioHardware.Selector.translateBundleIDToPlugin:              self = .hardwareTranslateBundleIDToPlugin
        case PancakeAudioHardware.Selector.transportManagerList:                   self = .hardwareTransportManagerList
        case PancakeAudioHardware.Selector.translateBundleIDToTransportManager:    self = .hardwareTranslateBundleIDToTransportManager
        case PancakeAudioHardware.Selector.boxList:                                self = .hardwareBoxList
        case PancakeAudioHardware.Selector.translateUIDToBox:                      self = .hardwareTranslateUIDToBox
        case PancakeAudioHardware.Selector.clockDeviceList:                        self = .hardwareClockDeviceList
        case PancakeAudioHardware.Selector.translateUIDToClockDevice:              self = .hardwareTranslateUIDToClockDevice
        case PancakeAudioHardware.Selector.processIsMaster:                        self = .hardwareProcessIsMaster
        case PancakeAudioHardware.Selector.isInitingOrExiting:                     self = .hardwareIsInitingOrExiting
        case PancakeAudioHardware.Selector.userIDChanged:                          self = .hardwareUserIDChanged
        case PancakeAudioHardware.Selector.processIsAudible:                       self = .hardwareProcessIsAudible
        case PancakeAudioHardware.Selector.sleepingIsAllowed:                      self = .hardwareSleepingIsAllowed
        case PancakeAudioHardware.Selector.unloadingIsAllowed:                     self = .hardwareUnloadingIsAllowed
        case PancakeAudioHardware.Selector.hogModeIsAllowed:                       self = .hardwareHogModeIsAllowed
        case PancakeAudioHardware.Selector.userSessionIsActiveOrHeadless:          self = .hardwareUserSessionIsActiveOrHeadless
        case PancakeAudioHardware.Selector.serviceRestarted:                       self = .hardwareServiceRestarted
        case PancakeAudioHardware.Selector.powerHint:                              self = .hardwarePowerHint
            
        // Plugin
        case PancakeAudioPlugin.Selector.createAggregateDevice:                    self = .pluginCreateAggregateDevice
        case PancakeAudioPlugin.Selector.destroyAggregateDevice:                   self = .pluginDestroyAggregateDevice
        case PancakeAudioPlugin.Selector.bundleID:                                 self = .pluginBundleID
        case PancakeAudioPlugin.Selector.deviceList:                               self = .pluginDeviceList
        case PancakeAudioPlugin.Selector.translateUIDToDevice:                     self = .pluginTranslateUIDToDevice
        case PancakeAudioPlugin.Selector.boxList:                                  self = .pluginBoxList
        case PancakeAudioPlugin.Selector.translateUIDToBox:                        self = .pluginTranslateUIDToBox
        case PancakeAudioPlugin.Selector.clockDeviceList:                          self = .pluginClockDeviceList
        case PancakeAudioPlugin.Selector.translateUIDToClockDevice:                self = .pluginTranslateUIDToClockDevice
        case PancakeAudioPlugin.Selector.resourceBundle:                           self = .pluginResourceBundle
            
        // AggregateDevice
        case PancakeAudioAggregateDevice.Selector.fullSubDeviceList:               self = .aggregateDeviceFullSubDeviceList
        case PancakeAudioAggregateDevice.Selector.activeSubDeviceList:             self = .aggregateDeviceActiveSubDeviceList
        case PancakeAudioAggregateDevice.Selector.composition:                     self = .aggregateDeviceComposition
        case PancakeAudioAggregateDevice.Selector.masterSubDevice:                 self = .aggregateDeviceMasterSubDevice
        case PancakeAudioAggregateDevice.Selector.clockDevice:                     self = .aggregateDeviceClockDevice
            
        // SubDevice
        case PancakeAudioSubDevice.Selector.extraLatency:                          self = .subDeviceExtraLatency
        case PancakeAudioSubDevice.Selector.driftCompensation:                     self = .subDeviceDriftCompensation
        case PancakeAudioSubDevice.Selector.driftCompensationQuality:              self = .subDeviceDriftCompensationQuality
            
        // TransportManager
        case PancakeAudioTransportManager.Selector.createEndPointDevice:           self = .transportManagerCreateEndPointDevice
        case PancakeAudioTransportManager.Selector.destroyEndPointDevice:          self = .transportManagerDestroyEndPointDevice
        case PancakeAudioTransportManager.Selector.endPointList:                   self = .transportManagerEndPointList
        case PancakeAudioTransportManager.Selector.translateUIDToEndPoint:         self = .transportManagerTranslateUIDToEndPoint
        /*
         See SelectorList.swift for explanation
         case PancakeAudioTransportManager.Selector.transportType:                  self = .transportManagerTransportType
         */
            
        // Box
        case PancakeAudioBox.Selector.UID:                                         self = .boxUID
        /*
         See SelectorList.swift for explanation
         case PancakeAudioBox.Selector.transportType:                               self = .boxTransportType
         */
        case PancakeAudioBox.Selector.hasAudio:                                    self = .boxHasAudio
        case PancakeAudioBox.Selector.hasVideo:                                    self = .boxHasVideo
        case PancakeAudioBox.Selector.hasMIDI:                                     self = .boxHasMIDI
        case PancakeAudioBox.Selector.isProtected:                                 self = .boxIsProtected
        case PancakeAudioBox.Selector.acquired:                                    self = .boxAcquired
        case PancakeAudioBox.Selector.acquisitionFailed:                           self = .boxAcquisitionFailed
        case PancakeAudioBox.Selector.deviceList:                                  self = .boxDeviceList
        case PancakeAudioBox.Selector.clockDeviceList:                             self = .boxClockDeviceList
            
        // Device
        case PancakeAudioDevice.Selector.plugin:                                   self = .devicePlugin
        case PancakeAudioDevice.Selector.hasChanged:                               self = .deviceHasChanged
        case PancakeAudioDevice.Selector.isRunningSomewhere:                       self = .deviceIsRunningSomewhere
        case PancakeAudioDevice.Selector.processorOverload:                        self = .deviceProcessorOverload
        case PancakeAudioDevice.Selector.IOStoppedAbnormally:                      self = .deviceIOStoppedAbnormally
        case PancakeAudioDevice.Selector.hogMode:                                  self = .deviceHogMode
        case PancakeAudioDevice.Selector.bufferFrameSize:                          self = .deviceBufferFrameSize
        case PancakeAudioDevice.Selector.bufferFrameSizeRange:                     self = .deviceBufferFrameSizeRange
        case PancakeAudioDevice.Selector.usesVariableBufferFrameSizes:             self = .deviceUsesVariableBufferFrameSizes
        case PancakeAudioDevice.Selector.IOCycleUsage:                             self = .deviceIOCycleUsage
        case PancakeAudioDevice.Selector.streamConfiguration:                      self = .deviceStreamConfiguration
        case PancakeAudioDevice.Selector.IOProcStreamUsage:                        self = .deviceIOProcStreamUsage
        case PancakeAudioDevice.Selector.actualSampleRate:                         self = .deviceActualSampleRate
        case PancakeAudioDevice.Selector.clockDevice:                              self = .deviceClockDevice
        case PancakeAudioDevice.Selector.jackIsConnected:                          self = .deviceJackIsConnected
        case PancakeAudioDevice.Selector.volumeScalar:                             self = .deviceVolumeScalar
        case PancakeAudioDevice.Selector.volumeDecibels:                           self = .deviceVolumeDecibels
        case PancakeAudioDevice.Selector.volumeRangeDecibels:                      self = .deviceVolumeRangeDecibels
        case PancakeAudioDevice.Selector.volumeScalarToDecibels:                   self = .deviceVolumeScalarToDecibels
        case PancakeAudioDevice.Selector.volumeDecibelsToScalar:                   self = .deviceVolumeDecibelsToScalar
        case PancakeAudioDevice.Selector.stereoPan:                                self = .deviceStereoPan
        case PancakeAudioDevice.Selector.stereoPanChannels:                        self = .deviceStereoPanChannels
        case PancakeAudioDevice.Selector.mute:                                     self = .deviceMute
        case PancakeAudioDevice.Selector.solo:                                     self = .deviceSolo
        case PancakeAudioDevice.Selector.phantomPower:                             self = .devicePhantomPower
        case PancakeAudioDevice.Selector.phaseInvert:                              self = .devicePhaseInvert
        case PancakeAudioDevice.Selector.clipLight:                                self = .deviceClipLight
        case PancakeAudioDevice.Selector.talkback:                                 self = .deviceTalkback
        case PancakeAudioDevice.Selector.listenback:                               self = .deviceListenback
        case PancakeAudioDevice.Selector.dataSource:                               self = .deviceDataSource
        case PancakeAudioDevice.Selector.dataSources:                              self = .deviceDataSources
        case PancakeAudioDevice.Selector.dataSourceNameForIDCFString:              self = .deviceDataSourceNameForIDCFString
        case PancakeAudioDevice.Selector.dataSourceKindForID:                      self = .deviceDataSourceKindForID
        case PancakeAudioDevice.Selector.clockSource:                              self = .deviceClockSource
        case PancakeAudioDevice.Selector.clockSources:                             self = .deviceClockSources
        case PancakeAudioDevice.Selector.clockSourceNameForIDCFString:             self = .deviceClockSourceNameForIDCFString
        case PancakeAudioDevice.Selector.clockSourceKindForID:                     self = .deviceClockSourceKindForID
        case PancakeAudioDevice.Selector.playThru:                                 self = .devicePlayThru
        case PancakeAudioDevice.Selector.playThruSolo:                             self = .devicePlayThruSolo
        case PancakeAudioDevice.Selector.playThruVolumeScalar:                     self = .devicePlayThruVolumeScalar
        case PancakeAudioDevice.Selector.playThruVolumeDecibels:                   self = .devicePlayThruVolumeDecibels
        case PancakeAudioDevice.Selector.playThruVolumeRangeDecibels:              self = .devicePlayThruVolumeRangeDecibels
        case PancakeAudioDevice.Selector.playThruVolumeScalarToDecibels:           self = .devicePlayThruVolumeScalarToDecibels
        case PancakeAudioDevice.Selector.playThruVolumeDecibelsToScalar:           self = .devicePlayThruVolumeDecibelsToScalar
        case PancakeAudioDevice.Selector.playThruStereoPan:                        self = .devicePlayThruStereoPan
        case PancakeAudioDevice.Selector.playThruStereoPanChannels:                self = .devicePlayThruStereoPanChannels
        case PancakeAudioDevice.Selector.playThruDestination:                      self = .devicePlayThruDestination
        case PancakeAudioDevice.Selector.playThruDestinations:                     self = .devicePlayThruDestinations
        case PancakeAudioDevice.Selector.playThruDestinationNameForIDCFString:     self = .devicePlayThruDestinationNameForIDCFString
        case PancakeAudioDevice.Selector.channelNominalLineLevel:                  self = .deviceChannelNominalLineLevel
        case PancakeAudioDevice.Selector.channelNominalLineLevels:                 self = .deviceChannelNominalLineLevels
        case PancakeAudioDevice.Selector.channelNominalLineLevelNameForIDCFString: self = .deviceChannelNominalLineLevelNameForIDCFString
        case PancakeAudioDevice.Selector.highPassFilterSetting:                    self = .deviceHighPassFilterSetting
        case PancakeAudioDevice.Selector.highPassFilterSettings:                   self = .deviceHighPassFilterSettings
        case PancakeAudioDevice.Selector.highPassFilterSettingNameForIDCFString:   self = .deviceHighPassFilterSettingNameForIDCFString
        case PancakeAudioDevice.Selector.subVolumeScalar:                          self = .deviceSubVolumeScalar
        case PancakeAudioDevice.Selector.subVolumeDecibels:                        self = .deviceSubVolumeDecibels
        case PancakeAudioDevice.Selector.subVolumeRangeDecibels:                   self = .deviceSubVolumeRangeDecibels
        case PancakeAudioDevice.Selector.subVolumeScalarToDecibels:                self = .deviceSubVolumeScalarToDecibels
        case PancakeAudioDevice.Selector.subVolumeDecibelsToScalar:                self = .deviceSubVolumeDecibelsToScalar
        case PancakeAudioDevice.Selector.subMute:                                  self = .deviceSubMute
        case PancakeAudioDevice.Selector.configurationApplication:                 self = .deviceConfigurationApplication
        case PancakeAudioDevice.Selector.UID:                                      self = .deviceUID
        case PancakeAudioDevice.Selector.modelUID:                                 self = .deviceModelUID
        case PancakeAudioDevice.Selector.transportType:                            self = .deviceTransportType
        case PancakeAudioDevice.Selector.relatedDevices:                           self = .deviceRelatedDevices
        case PancakeAudioDevice.Selector.clockDomain:                              self = .deviceClockDomain
        case PancakeAudioDevice.Selector.isAlive:                                  self = .deviceIsAlive
        case PancakeAudioDevice.Selector.isRunning:                                self = .deviceIsRunning
        case PancakeAudioDevice.Selector.canBeDefaultDevice:                       self = .deviceCanBeDefaultDevice
        case PancakeAudioDevice.Selector.canBeDefaultSystemDevice:                 self = .deviceCanBeDefaultSystemDevice
        case PancakeAudioDevice.Selector.latency:                                  self = .deviceLatency
        case PancakeAudioDevice.Selector.streams:                                  self = .deviceStreams
        case PancakeAudioDevice.Selector.controlList:                              self = .deviceControlList
        case PancakeAudioDevice.Selector.safetyOffset:                             self = .deviceSafetyOffset
        case PancakeAudioDevice.Selector.nominalSampleRate:                        self = .deviceNominalSampleRate
        case PancakeAudioDevice.Selector.availableNominalSampleRates:              self = .deviceAvailableNominalSampleRates
        case PancakeAudioDevice.Selector.icon:                                     self = .deviceIcon
        case PancakeAudioDevice.Selector.isHidden:                                 self = .deviceIsHidden
        case PancakeAudioDevice.Selector.preferredChannelsForStereo:               self = .devicePreferredChannelsForStereo
        case PancakeAudioDevice.Selector.preferredChannelLayout:                   self = .devicePreferredChannelLayout
        case PancakeAudioDevice.Selector.zeroTimeStampPeriod:                      self = .deviceZeroTimeStampPeriod
        case PancakeAudioDevice.Selector.clockAlgorithm:                           self = .deviceClockAlgorithm
        case PancakeAudioDevice.Selector.clockIsStable:                            self = .deviceClockIsStable
            
        // ClockDevice
        case PancakeAudioClockDevice.Selector.UID:                                 self = .clockDeviceUID
        /*
         See SelectorList.swift for explanation
         case PancakeAudioClockDevice.Selector.transportType:                       self = .clockDeviceTransportType
         case PancakeAudioClockDevice.Selector.clockDomain:                         self = .clockDeviceClockDomain
         case PancakeAudioClockDevice.Selector.isAlive:                             self = .clockDeviceIsAlive
         case PancakeAudioClockDevice.Selector.isRunning:                           self = .clockDeviceIsRunning
         case PancakeAudioClockDevice.Selector.latency:                             self = .clockDeviceLatency
         case PancakeAudioClockDevice.Selector.controlList:                         self = .clockDeviceControlList
         case PancakeAudioClockDevice.Selector.nominalSampleRate:                   self = .clockDeviceNominalSampleRate
         case PancakeAudioClockDevice.Selector.availableNominalSampleRates:         self = .clockDeviceAvailableNominalSampleRates
        */
            
        // EndPointDevice
        case PancakeAudioEndPointDevice.Selector.composition:                      self = .endPointDeviceComposition
        case PancakeAudioEndPointDevice.Selector.endPointList:                     self = .endPointDeviceEndPointList
        case PancakeAudioEndPointDevice.Selector.isPrivate:                        self = .endPointDeviceIsPrivate
            
        // Stream
        case PancakeAudioStream.Selector.isActive:                                 self = .streamIsActive
        case PancakeAudioStream.Selector.direction:                                self = .streamDirection
        case PancakeAudioStream.Selector.terminalType:                             self = .streamTerminalType
        case PancakeAudioStream.Selector.startingChannel:                          self = .streamStartingChannel
        case PancakeAudioStream.Selector.latency:                                  self = .streamLatency
        case PancakeAudioStream.Selector.virtualFormat:                            self = .streamVirtualFormat
        case PancakeAudioStream.Selector.availableVirtualFormats:                  self = .streamAvailableVirtualFormats
        case PancakeAudioStream.Selector.physicalFormat:                           self = .streamPhysicalFormat
        case PancakeAudioStream.Selector.availablePhysicalFormats:                 self = .streamAvailablePhysicalFormats
            
        // Control
        case PancakeAudioControl.Selector.scope:                                   self = .controlScope
        case PancakeAudioControl.Selector.element:                                 self = .controlElement
            
        // SliderControl
        case PancakeAudioSliderControl.Selector.value:                             self = .sliderControlValue
        case PancakeAudioSliderControl.Selector.range:                             self = .sliderControlRange
            
        // LevelControl
        case PancakeAudioLevelControl.Selector.scalarValue:                        self = .levelControlScalarValue
        case PancakeAudioLevelControl.Selector.decibelValue:                       self = .levelControlDecibelValue
        case PancakeAudioLevelControl.Selector.decibelRange:                       self = .levelControlDecibelRange
        case PancakeAudioLevelControl.Selector.convertScalarToDecibels:            self = .levelControlConvertScalarToDecibels
        case PancakeAudioLevelControl.Selector.convertDecibelsToScalar:            self = .levelControlConvertDecibelsToScalar
            
        // BooleanControl
        case PancakeAudioBooleanControl.Selector.value:                            self = .booleanControlValue
            
        // SelectorControl
        case PancakeAudioSelectorControl.Selector.currentItem:                     self = .selectorControlCurrentItem
        case PancakeAudioSelectorControl.Selector.availableItems:                  self = .selectorControlAvailableItems
        case PancakeAudioSelectorControl.Selector.itemName:                        self = .selectorControlItemName
        case PancakeAudioSelectorControl.Selector.itemKind:                        self = .selectorControlItemKind
            
        // StereoPanControl
        case PancakeAudioStereoPanControl.Selector.value:                          self = .stereoPanControlValue
        case PancakeAudioStereoPanControl.Selector.panningChannels:                self = .stereoPanControlPanningChannels

        // Unclear
        case 1667658618: fallthrough // 'cfsz'
        case 1685287012:             // 'dspd'
            return nil

        // Unknown property
        default:
            let text = String(fourCharCode: rawValue)
            assertionFailure("Selector '\(text)' not known.")
            return nil
        }
    }

    
    
    public var rawValue: AudioObjectPropertySelector {
        switch self {
        // Object
        case .objectCreator:                                  return PancakeAudioObject.Selector.creator
        case .objectListenerAdded:                            return PancakeAudioObject.Selector.listenerAdded
        case .objectListenerRemoved:                          return PancakeAudioObject.Selector.listenerRemoved
        case .objectBaseClass:                                return PancakeAudioObject.Selector.baseClass
        case .objectClass:                                    return PancakeAudioObject.Selector.class
        case .objectOwner:                                    return PancakeAudioObject.Selector.owner
        case .objectName:                                     return PancakeAudioObject.Selector.name
        case .objectModelName:                                return PancakeAudioObject.Selector.modelName
        case .objectManufacturer:                             return PancakeAudioObject.Selector.manufacturer
        case .objectElementName:                              return PancakeAudioObject.Selector.elementName
        case .objectElementCategoryName:                      return PancakeAudioObject.Selector.elementCategoryName
        case .objectElementNumberName:                        return PancakeAudioObject.Selector.elementNumberName
        case .objectOwnedObjects:                             return PancakeAudioObject.Selector.ownedObjects
        case .objectIdentify:                                 return PancakeAudioObject.Selector.identify
        case .objectSerialNumber:                             return PancakeAudioObject.Selector.serialNumber
        case .objectFirmwareVersion:                          return PancakeAudioObject.Selector.firmwareVersion
        case .objectWildcard:                                 return PancakeAudioObject.Selector.wildcard
        case .objectCustomPropertyInfoList:                   return PancakeAudioObject.Selector.customPropertyInfoList
            
        // Hardware
        case .hardwareDevices:                                return PancakeAudioHardware.Selector.devices
        case .hardwareDefaultInputDevice:                     return PancakeAudioHardware.Selector.defaultInputDevice
        case .hardwareDefaultOutputDevice:                    return PancakeAudioHardware.Selector.defaultOutputDevice
        case .hardwareDefaultSystemOutputDevice:              return PancakeAudioHardware.Selector.defaultSystemOutputDevice
        case .hardwareTranslateUIDToDevice:                   return PancakeAudioHardware.Selector.translateUIDToDevice
        case .hardwareMixStereoToMono:                        return PancakeAudioHardware.Selector.mixStereoToMono
        case .hardwarePluginList:                             return PancakeAudioHardware.Selector.pluginList
        case .hardwareTranslateBundleIDToPlugin:              return PancakeAudioHardware.Selector.translateBundleIDToPlugin
        case .hardwareTransportManagerList:                   return PancakeAudioHardware.Selector.transportManagerList
        case .hardwareTranslateBundleIDToTransportManager:    return PancakeAudioHardware.Selector.translateBundleIDToTransportManager
        case .hardwareBoxList:                                return PancakeAudioHardware.Selector.boxList
        case .hardwareTranslateUIDToBox:                      return PancakeAudioHardware.Selector.translateUIDToBox
        case .hardwareClockDeviceList:                        return PancakeAudioHardware.Selector.clockDeviceList
        case .hardwareTranslateUIDToClockDevice:              return PancakeAudioHardware.Selector.translateUIDToClockDevice
        case .hardwareProcessIsMaster:                        return PancakeAudioHardware.Selector.processIsMaster
        case .hardwareIsInitingOrExiting:                     return PancakeAudioHardware.Selector.isInitingOrExiting
        case .hardwareUserIDChanged:                          return PancakeAudioHardware.Selector.userIDChanged
        case .hardwareProcessIsAudible:                       return PancakeAudioHardware.Selector.processIsAudible
        case .hardwareSleepingIsAllowed:                      return PancakeAudioHardware.Selector.sleepingIsAllowed
        case .hardwareUnloadingIsAllowed:                     return PancakeAudioHardware.Selector.unloadingIsAllowed
        case .hardwareHogModeIsAllowed:                       return PancakeAudioHardware.Selector.hogModeIsAllowed
        case .hardwareUserSessionIsActiveOrHeadless:          return PancakeAudioHardware.Selector.userSessionIsActiveOrHeadless
        case .hardwareServiceRestarted:                       return PancakeAudioHardware.Selector.serviceRestarted
        case .hardwarePowerHint:                              return PancakeAudioHardware.Selector.powerHint
            
        // Plugin
        case .pluginCreateAggregateDevice:                    return PancakeAudioPlugin.Selector.createAggregateDevice
        case .pluginDestroyAggregateDevice:                   return PancakeAudioPlugin.Selector.destroyAggregateDevice
        case .pluginBundleID:                                 return PancakeAudioPlugin.Selector.bundleID
        case .pluginDeviceList:                               return PancakeAudioPlugin.Selector.deviceList
        case .pluginTranslateUIDToDevice:                     return PancakeAudioPlugin.Selector.translateUIDToDevice
        case .pluginBoxList:                                  return PancakeAudioPlugin.Selector.boxList
        case .pluginTranslateUIDToBox:                        return PancakeAudioPlugin.Selector.translateUIDToBox
        case .pluginClockDeviceList:                          return PancakeAudioPlugin.Selector.clockDeviceList
        case .pluginTranslateUIDToClockDevice:                return PancakeAudioPlugin.Selector.translateUIDToClockDevice
        case .pluginResourceBundle:                           return PancakeAudioPlugin.Selector.resourceBundle
            
        // AggregateDevice
        case .aggregateDeviceFullSubDeviceList:               return PancakeAudioAggregateDevice.Selector.fullSubDeviceList
        case .aggregateDeviceActiveSubDeviceList:             return PancakeAudioAggregateDevice.Selector.activeSubDeviceList
        case .aggregateDeviceComposition:                     return PancakeAudioAggregateDevice.Selector.composition
        case .aggregateDeviceMasterSubDevice:                 return PancakeAudioAggregateDevice.Selector.masterSubDevice
        case .aggregateDeviceClockDevice:                     return PancakeAudioAggregateDevice.Selector.clockDevice
            
        // SubDevice
        case .subDeviceExtraLatency:                          return PancakeAudioSubDevice.Selector.extraLatency
        case .subDeviceDriftCompensation:                     return PancakeAudioSubDevice.Selector.driftCompensation
        case .subDeviceDriftCompensationQuality:              return PancakeAudioSubDevice.Selector.driftCompensationQuality
            
        // TransportManager
        case .transportManagerCreateEndPointDevice:           return PancakeAudioTransportManager.Selector.createEndPointDevice
        case .transportManagerDestroyEndPointDevice:          return PancakeAudioTransportManager.Selector.destroyEndPointDevice
        case .transportManagerEndPointList:                   return PancakeAudioTransportManager.Selector.endPointList
        case .transportManagerTranslateUIDToEndPoint:         return PancakeAudioTransportManager.Selector.translateUIDToEndPoint
        /*
         See SelectorList.swift for explanation
         case .transportManagerTransportType:                  return PancakeAudioTransportManager.Selector.transportType
         */
            
        // Box
        case .boxUID:                                         return PancakeAudioBox.Selector.UID
        /*
         See SelectorList.swift for explanation
         case .boxTransportType:                               return PancakeAudioBox.Selector.transportType
         */
        case .boxHasAudio:                                    return PancakeAudioBox.Selector.hasAudio
        case .boxHasVideo:                                    return PancakeAudioBox.Selector.hasVideo
        case .boxHasMIDI:                                     return PancakeAudioBox.Selector.hasMIDI
        case .boxIsProtected:                                 return PancakeAudioBox.Selector.isProtected
        case .boxAcquired:                                    return PancakeAudioBox.Selector.acquired
        case .boxAcquisitionFailed:                           return PancakeAudioBox.Selector.acquisitionFailed
        case .boxDeviceList:                                  return PancakeAudioBox.Selector.deviceList
        case .boxClockDeviceList:                             return PancakeAudioBox.Selector.clockDeviceList
            
        // Device
        case .devicePlugin:                                   return PancakeAudioDevice.Selector.plugin
        case .deviceHasChanged:                               return PancakeAudioDevice.Selector.hasChanged
        case .deviceIsRunningSomewhere:                       return PancakeAudioDevice.Selector.isRunningSomewhere
        case .deviceProcessorOverload:                        return PancakeAudioDevice.Selector.processorOverload
        case .deviceIOStoppedAbnormally:                      return PancakeAudioDevice.Selector.IOStoppedAbnormally
        case .deviceHogMode:                                  return PancakeAudioDevice.Selector.hogMode
        case .deviceBufferFrameSize:                          return PancakeAudioDevice.Selector.bufferFrameSize
        case .deviceBufferFrameSizeRange:                     return PancakeAudioDevice.Selector.bufferFrameSizeRange
        case .deviceUsesVariableBufferFrameSizes:             return PancakeAudioDevice.Selector.usesVariableBufferFrameSizes
        case .deviceIOCycleUsage:                             return PancakeAudioDevice.Selector.IOCycleUsage
        case .deviceStreamConfiguration:                      return PancakeAudioDevice.Selector.streamConfiguration
        case .deviceIOProcStreamUsage:                        return PancakeAudioDevice.Selector.IOProcStreamUsage
        case .deviceActualSampleRate:                         return PancakeAudioDevice.Selector.actualSampleRate
        case .deviceClockDevice:                              return PancakeAudioDevice.Selector.clockDevice
        case .deviceJackIsConnected:                          return PancakeAudioDevice.Selector.jackIsConnected
        case .deviceVolumeScalar:                             return PancakeAudioDevice.Selector.volumeScalar
        case .deviceVolumeDecibels:                           return PancakeAudioDevice.Selector.volumeDecibels
        case .deviceVolumeRangeDecibels:                      return PancakeAudioDevice.Selector.volumeRangeDecibels
        case .deviceVolumeScalarToDecibels:                   return PancakeAudioDevice.Selector.volumeScalarToDecibels
        case .deviceVolumeDecibelsToScalar:                   return PancakeAudioDevice.Selector.volumeDecibelsToScalar
        case .deviceStereoPan:                                return PancakeAudioDevice.Selector.stereoPan
        case .deviceStereoPanChannels:                        return PancakeAudioDevice.Selector.stereoPanChannels
        case .deviceMute:                                     return PancakeAudioDevice.Selector.mute
        case .deviceSolo:                                     return PancakeAudioDevice.Selector.solo
        case .devicePhantomPower:                             return PancakeAudioDevice.Selector.phantomPower
        case .devicePhaseInvert:                              return PancakeAudioDevice.Selector.phaseInvert
        case .deviceClipLight:                                return PancakeAudioDevice.Selector.clipLight
        case .deviceTalkback:                                 return PancakeAudioDevice.Selector.talkback
        case .deviceListenback:                               return PancakeAudioDevice.Selector.listenback
        case .deviceDataSource:                               return PancakeAudioDevice.Selector.dataSource
        case .deviceDataSources:                              return PancakeAudioDevice.Selector.dataSources
        case .deviceDataSourceNameForIDCFString:              return PancakeAudioDevice.Selector.dataSourceNameForIDCFString
        case .deviceDataSourceKindForID:                      return PancakeAudioDevice.Selector.dataSourceKindForID
        case .deviceClockSource:                              return PancakeAudioDevice.Selector.clockSource
        case .deviceClockSources:                             return PancakeAudioDevice.Selector.clockSources
        case .deviceClockSourceNameForIDCFString:             return PancakeAudioDevice.Selector.clockSourceNameForIDCFString
        case .deviceClockSourceKindForID:                     return PancakeAudioDevice.Selector.clockSourceKindForID
        case .devicePlayThru:                                 return PancakeAudioDevice.Selector.playThru
        case .devicePlayThruSolo:                             return PancakeAudioDevice.Selector.playThruSolo
        case .devicePlayThruVolumeScalar:                     return PancakeAudioDevice.Selector.playThruVolumeScalar
        case .devicePlayThruVolumeDecibels:                   return PancakeAudioDevice.Selector.playThruVolumeDecibels
        case .devicePlayThruVolumeRangeDecibels:              return PancakeAudioDevice.Selector.playThruVolumeRangeDecibels
        case .devicePlayThruVolumeScalarToDecibels:           return PancakeAudioDevice.Selector.playThruVolumeScalarToDecibels
        case .devicePlayThruVolumeDecibelsToScalar:           return PancakeAudioDevice.Selector.playThruVolumeDecibelsToScalar
        case .devicePlayThruStereoPan:                        return PancakeAudioDevice.Selector.playThruStereoPan
        case .devicePlayThruStereoPanChannels:                return PancakeAudioDevice.Selector.playThruStereoPanChannels
        case .devicePlayThruDestination:                      return PancakeAudioDevice.Selector.playThruDestination
        case .devicePlayThruDestinations:                     return PancakeAudioDevice.Selector.playThruDestinations
        case .devicePlayThruDestinationNameForIDCFString:     return PancakeAudioDevice.Selector.playThruDestinationNameForIDCFString
        case .deviceChannelNominalLineLevel:                  return PancakeAudioDevice.Selector.channelNominalLineLevel
        case .deviceChannelNominalLineLevels:                 return PancakeAudioDevice.Selector.channelNominalLineLevels
        case .deviceChannelNominalLineLevelNameForIDCFString: return PancakeAudioDevice.Selector.channelNominalLineLevelNameForIDCFString
        case .deviceHighPassFilterSetting:                    return PancakeAudioDevice.Selector.highPassFilterSetting
        case .deviceHighPassFilterSettings:                   return PancakeAudioDevice.Selector.highPassFilterSettings
        case .deviceHighPassFilterSettingNameForIDCFString:   return PancakeAudioDevice.Selector.highPassFilterSettingNameForIDCFString
        case .deviceSubVolumeScalar:                          return PancakeAudioDevice.Selector.subVolumeScalar
        case .deviceSubVolumeDecibels:                        return PancakeAudioDevice.Selector.subVolumeDecibels
        case .deviceSubVolumeRangeDecibels:                   return PancakeAudioDevice.Selector.subVolumeRangeDecibels
        case .deviceSubVolumeScalarToDecibels:                return PancakeAudioDevice.Selector.subVolumeScalarToDecibels
        case .deviceSubVolumeDecibelsToScalar:                return PancakeAudioDevice.Selector.subVolumeDecibelsToScalar
        case .deviceSubMute:                                  return PancakeAudioDevice.Selector.subMute
        case .deviceConfigurationApplication:                 return PancakeAudioDevice.Selector.configurationApplication
        case .deviceUID:                                      return PancakeAudioDevice.Selector.UID
        case .deviceModelUID:                                 return PancakeAudioDevice.Selector.modelUID
        case .deviceTransportType:                            return PancakeAudioDevice.Selector.transportType
        case .deviceRelatedDevices:                           return PancakeAudioDevice.Selector.relatedDevices
        case .deviceClockDomain:                              return PancakeAudioDevice.Selector.clockDomain
        case .deviceIsAlive:                                  return PancakeAudioDevice.Selector.isAlive
        case .deviceIsRunning:                                return PancakeAudioDevice.Selector.isRunning
        case .deviceCanBeDefaultDevice:                       return PancakeAudioDevice.Selector.canBeDefaultDevice
        case .deviceCanBeDefaultSystemDevice:                 return PancakeAudioDevice.Selector.canBeDefaultSystemDevice
        case .deviceLatency:                                  return PancakeAudioDevice.Selector.latency
        case .deviceStreams:                                  return PancakeAudioDevice.Selector.streams
        case .deviceControlList:                              return PancakeAudioDevice.Selector.controlList
        case .deviceSafetyOffset:                             return PancakeAudioDevice.Selector.safetyOffset
        case .deviceNominalSampleRate:                        return PancakeAudioDevice.Selector.nominalSampleRate
        case .deviceAvailableNominalSampleRates:              return PancakeAudioDevice.Selector.availableNominalSampleRates
        case .deviceIcon:                                     return PancakeAudioDevice.Selector.icon
        case .deviceIsHidden:                                 return PancakeAudioDevice.Selector.isHidden
        case .devicePreferredChannelsForStereo:               return PancakeAudioDevice.Selector.preferredChannelsForStereo
        case .devicePreferredChannelLayout:                   return PancakeAudioDevice.Selector.preferredChannelLayout
        case .deviceZeroTimeStampPeriod:                      return PancakeAudioDevice.Selector.zeroTimeStampPeriod
        case .deviceClockAlgorithm:                           return PancakeAudioDevice.Selector.clockAlgorithm
        case .deviceClockIsStable:                            return PancakeAudioDevice.Selector.clockIsStable
            
        // ClockDevice
        case .clockDeviceUID:                                 return PancakeAudioClockDevice.Selector.UID
        /*
         See SelectorList.swift for explanation
         case .clockDeviceTransportType:                       return PancakeAudioClockDevice.Selector.transportType
         case .clockDeviceClockDomain:                         return PancakeAudioClockDevice.Selector.clockDomain
         case .clockDeviceIsAlive:                             return PancakeAudioClockDevice.Selector.isAlive
         case .clockDeviceIsRunning:                           return PancakeAudioClockDevice.Selector.isRunning
         case .clockDeviceLatency:                             return PancakeAudioClockDevice.Selector.latency
         case .clockDeviceControlList:                         return PancakeAudioClockDevice.Selector.controlList
         case .clockDeviceNominalSampleRate:                   return PancakeAudioClockDevice.Selector.nominalSampleRate
         case .clockDeviceAvailableNominalSampleRates:         return PancakeAudioClockDevice.Selector.availableNominalSampleRates
         */
            
        // EndPointDevice
        case .endPointDeviceComposition:                      return PancakeAudioEndPointDevice.Selector.composition
        case .endPointDeviceEndPointList:                     return PancakeAudioEndPointDevice.Selector.endPointList
        case .endPointDeviceIsPrivate:                        return PancakeAudioEndPointDevice.Selector.isPrivate
            
        // Stream
        case .streamIsActive:                                 return PancakeAudioStream.Selector.isActive
        case .streamDirection:                                return PancakeAudioStream.Selector.direction
        case .streamTerminalType:                             return PancakeAudioStream.Selector.terminalType
        case .streamStartingChannel:                          return PancakeAudioStream.Selector.startingChannel
        case .streamLatency:                                  return PancakeAudioStream.Selector.latency
        case .streamVirtualFormat:                            return PancakeAudioStream.Selector.virtualFormat
        case .streamAvailableVirtualFormats:                  return PancakeAudioStream.Selector.availableVirtualFormats
        case .streamPhysicalFormat:                           return PancakeAudioStream.Selector.physicalFormat
        case .streamAvailablePhysicalFormats:                 return PancakeAudioStream.Selector.availablePhysicalFormats
            
        // Control
        case .controlScope:                                   return PancakeAudioControl.Selector.scope
        case .controlElement:                                 return PancakeAudioControl.Selector.element
            
        // SliderControl
        case .sliderControlValue:                             return PancakeAudioSliderControl.Selector.value
        case .sliderControlRange:                             return PancakeAudioSliderControl.Selector.range
            
        // LevelControl
        case .levelControlScalarValue:                        return PancakeAudioLevelControl.Selector.scalarValue
        case .levelControlDecibelValue:                       return PancakeAudioLevelControl.Selector.decibelValue
        case .levelControlDecibelRange:                       return PancakeAudioLevelControl.Selector.decibelRange
        case .levelControlConvertScalarToDecibels:            return PancakeAudioLevelControl.Selector.convertScalarToDecibels
        case .levelControlConvertDecibelsToScalar:            return PancakeAudioLevelControl.Selector.convertDecibelsToScalar
            
        // BooleanControl
        case .booleanControlValue:                            return PancakeAudioBooleanControl.Selector.value
            
        // SelectorControl
        case .selectorControlCurrentItem:                     return PancakeAudioSelectorControl.Selector.currentItem
        case .selectorControlAvailableItems:                  return PancakeAudioSelectorControl.Selector.availableItems
        case .selectorControlItemName:                        return PancakeAudioSelectorControl.Selector.itemName
        case .selectorControlItemKind:                        return PancakeAudioSelectorControl.Selector.itemKind
            
        // StereoPanControl
        case .stereoPanControlValue:                          return PancakeAudioStereoPanControl.Selector.value
        case .stereoPanControlPanningChannels:                return PancakeAudioStereoPanControl.Selector.panningChannels
        }
    }
}

