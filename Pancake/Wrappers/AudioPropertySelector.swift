//
//  PancakeAudioPropertySelector.swift
//  Pancake
//
//  Created by mxa on 31.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioHardwareBase
import CoreAudio.AudioServerPlugIn


enum PancakeAudioObjectPropertySelector {
    // PancakeAudioObject
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
    case objectCustomPropertyInfoList   // From PancakeAudioServerPlugIn.h
    
    // PancakeAudioPlugin
    case pluginBundleID
    case pluginDeviceList
    case pluginTranslateUIDToDevice
    case pluginBoxList
    case pluginTranslateUIDToBox
    case pluginClockDeviceList
    case pluginTranslateUIDToClockDevice
    
    // PancakeAudioTransportManager
    case transportManagerEndPointList
    case transportManagerTranslateUIDToEndPoint
    case transportManagerTransportType
    
    // PancakeAudioBox
    case boxUID
    case boxTransportType
    case boxHasAudio
    case boxHasVideo
    case boxHasMIDI
    case boxIsProtected
    case boxAcquired
    case boxAcquisitionFailed
    case boxDeviceList
    case boxClockDeviceList
    
    // PancakeAudioDevice
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
    case deviceZeroTimeStampPeriod  // From PancakeAudioServerPlugIn.h
    case deviceClockAlgorithm       // From PancakeAudioServerPlugIn.h
    case deviceClockIsStable        // From PancakeAudioServerPlugIn.h
    
    // PancakeAudioClockDevice
    case clockDeviceUID
    case clockDeviceTransportType
    case clockDeviceClockDomain
    case clockDeviceIsAlive
    case clockDeviceIsRunning
    case clockDeviceLatency
    case clockDeviceControlList
    case clockDeviceNominalSampleRate
    case clockDeviceAvailableNominalSampleRates
    
    // PancakeAudioEndPointDevice
    case endPointDeviceComposition
    case endPointDeviceEndPointList
    case endPointDeviceIsPrivate
    
    // PancakeAudioEndPoint
    case streamIsActive
    case streamDirection
    case streamTerminalType
    case streamStartingChannel
    case streamLatency
    case streamVirtualFormat
    case streamAvailableVirtualFormats
    case streamPhysicalFormat
    case streamAvailablePhysicalFormats
    
    // PancakeAudioControl
    case controlScope
    case controlElement
    
    // PancakeAudioSliderControl
    case sliderControlValue
    case sliderControlRange
    
    // PancakeAudioLevelControl
    case levelControlScalarValue
    case levelControlDecibelValue
    case levelControlDecibelRange
    case levelControlConvertScalarToDecibels
    case levelControlConvertDecibelsToScalar
    
    // PancakeAudioBooleanControl
    case booleanControlValue
    
    // PancakeAudioSelectorControl
    case selectorControlCurrentItem
    case selectorControlAvailableItems
    case selectorControlItemName
    case selectorControlItemKind
    
    // PancakeAudioStereoPanControl
    case stereoPanControlValue
    case stereoPanControlPanningChannels
}


// MARK: - Initializer
extension PancakeAudioObjectPropertySelector {
    init?(from selector: AudioObjectPropertySelector) {
        switch selector {
        // PancakeAudioObject
        case PancakeAudioObject.Selector.baseClass:                        self = .objectBaseClass
        case PancakeAudioObject.Selector.class:                            self = .objectClass
        case PancakeAudioObject.Selector.owner:                            self = .objectOwner
        case PancakeAudioObject.Selector.name:                             self = .objectName
        case PancakeAudioObject.Selector.modelName:                        self = .objectModelName
        case PancakeAudioObject.Selector.manufacturer:                     self = .objectManufacturer
        case PancakeAudioObject.Selector.elementName:                      self = .objectElementName
        case PancakeAudioObject.Selector.elementCategoryName:              self = .objectElementCategoryName
        case PancakeAudioObject.Selector.elementNumberName:                self = .objectElementNumberName
        case PancakeAudioObject.Selector.ownedObjects:                     self = .objectOwnedObjects
        case PancakeAudioObject.Selector.identify:                         self = .objectIdentify
        case PancakeAudioObject.Selector.serialNumber:                     self = .objectSerialNumber
        case PancakeAudioObject.Selector.firmwareVersion:                  self = .objectFirmwareVersion
            
        // PancakeAudioPlugin
        case PancakeAudioPlugin.Selector.bundleID:                         self = .pluginBundleID
        case PancakeAudioPlugin.Selector.deviceList:                       self = .pluginDeviceList
        case PancakeAudioPlugin.Selector.translateUIDToDevice:             self = .pluginTranslateUIDToDevice
        case PancakeAudioPlugin.Selector.boxList:                          self = .pluginBoxList
        case PancakeAudioPlugin.Selector.translateUIDToBox:                self = .pluginTranslateUIDToBox
        case PancakeAudioPlugin.Selector.clockDeviceList:                  self = .pluginClockDeviceList
        case PancakeAudioPlugin.Selector.translateUIDToClockDevice:        self = .pluginTranslateUIDToClockDevice
            
        // PancakeAudioTransportManager
        case PancakeAudioTransportManager.Selector.endPointList:           self = .transportManagerEndPointList
        case PancakeAudioTransportManager.Selector.translateUIDToEndPoint: self = .transportManagerTranslateUIDToEndPoint
        case PancakeAudioTransportManager.Selector.transportType:          self = .transportManagerTransportType
            
        // PancakeAudioBox
        case PancakeAudioBox.Selector.boxUID:                              self = .boxUID
        case PancakeAudioBox.Selector.transportType:                       self = .boxTransportType
        case PancakeAudioBox.Selector.hasAudio:                            self = .boxHasAudio
        case PancakeAudioBox.Selector.hasVideo:                            self = .boxHasVideo
        case PancakeAudioBox.Selector.hasMIDI:                             self = .boxHasMIDI
        case PancakeAudioBox.Selector.isProtected:                         self = .boxIsProtected
        case PancakeAudioBox.Selector.acquired:                            self = .boxAcquired
        case PancakeAudioBox.Selector.acquisitionFailed:                   self = .boxAcquisitionFailed
        case PancakeAudioBox.Selector.deviceList:                          self = .boxDeviceList
        case PancakeAudioBox.Selector.clockDeviceList:                     self = .boxClockDeviceList
            
        // PancakeAudioDevice
        case PancakeAudioDevice.Selector.configurationApplication:         self = .deviceConfigurationApplication
        case PancakeAudioDevice.Selector.deviceUID:                        self = .deviceUID
        case PancakeAudioDevice.Selector.modelUID:                         self = .deviceModelUID
        case PancakeAudioDevice.Selector.transportType:                    self = .deviceTransportType
        case PancakeAudioDevice.Selector.relatedDevices:                   self = .deviceRelatedDevices
        case PancakeAudioDevice.Selector.clockDomain:                      self = .deviceClockDomain
        case PancakeAudioDevice.Selector.deviceIsAlive:                    self = .deviceIsAlive
        case PancakeAudioDevice.Selector.deviceIsRunning:                  self = .deviceIsRunning
        case PancakeAudioDevice.Selector.deviceCanBeDefaultDevice:         self = .deviceCanBeDefaultDevice
        case PancakeAudioDevice.Selector.deviceCanBeDefaultSystemDevice:   self = .deviceCanBeDefaultSystemDevice
        case PancakeAudioDevice.Selector.latency:                          self = .deviceLatency
        case PancakeAudioDevice.Selector.streams:                          self = .deviceStreams
        case PancakeAudioDevice.Selector.controlList:                      self = .deviceControlList
        case PancakeAudioDevice.Selector.safetyOffset:                     self = .deviceSafetyOffset
        case PancakeAudioDevice.Selector.nominalSampleRate:                self = .deviceNominalSampleRate
        case PancakeAudioDevice.Selector.availableNominalSampleRates:      self = .deviceAvailableNominalSampleRates
        case PancakeAudioDevice.Selector.icon:                             self = .deviceIcon
        case PancakeAudioDevice.Selector.isHidden:                         self = .deviceIsHidden
        case PancakeAudioDevice.Selector.preferredChannelsForStereo:       self = .devicePreferredChannelsForStereo
        case PancakeAudioDevice.Selector.preferredChannelLayout:           self = .devicePreferredChannelLayout
            
        // PancakeAudioClockDevice
        case PancakeAudioClockDevice.Selector.deviceUID:                   self = .clockDeviceUID
        case PancakeAudioClockDevice.Selector.transportType:               self = .clockDeviceTransportType
        case PancakeAudioClockDevice.Selector.clockDomain:                 self = .clockDeviceClockDomain
        case PancakeAudioClockDevice.Selector.deviceIsAlive:               self = .clockDeviceIsAlive
        case PancakeAudioClockDevice.Selector.deviceIsRunning:             self = .clockDeviceIsRunning
        case PancakeAudioClockDevice.Selector.latency:                     self = .clockDeviceLatency
        case PancakeAudioClockDevice.Selector.controlList:                 self = .clockDeviceControlList
        case PancakeAudioClockDevice.Selector.nominalSampleRate:           self = .clockDeviceNominalSampleRate
        case PancakeAudioClockDevice.Selector.availableNominalSampleRates: self = .clockDeviceAvailableNominalSampleRates
            
        // PancakeAudioEndPointDevice
        case PancakeAudioEndPointDevice.Selector.composition:              self = .endPointDeviceComposition
        case PancakeAudioEndPointDevice.Selector.endPointList:             self = .endPointDeviceEndPointList
        case PancakeAudioEndPointDevice.Selector.isPrivate:                self = .endPointDeviceIsPrivate
            
        // PancakeAudioEndPoint
        case PancakeAudioStream.Selector.isActive:                         self = .streamIsActive
        case PancakeAudioStream.Selector.direction:                        self = .streamDirection
        case PancakeAudioStream.Selector.terminalType:                     self = .streamTerminalType
        case PancakeAudioStream.Selector.startingChannel:                  self = .streamStartingChannel
        case PancakeAudioStream.Selector.latency:                          self = .streamLatency
        case PancakeAudioStream.Selector.virtualFormat:                    self = .streamVirtualFormat
        case PancakeAudioStream.Selector.availableVirtualFormats:          self = .streamAvailableVirtualFormats
        case PancakeAudioStream.Selector.physicalFormat:                   self = .streamPhysicalFormat
        case PancakeAudioStream.Selector.availablePhysicalFormats:         self = .streamAvailablePhysicalFormats
            
        // PancakeAudioControl
        case PancakeAudioControl.Selector.scope:                           self = .controlScope
        case PancakeAudioControl.Selector.element:                         self = .controlElement
            
        // PancakeAudioSliderControl
        case PancakeAudioSliderControl.Selector.value:                     self = .sliderControlValue
        case PancakeAudioSliderControl.Selector.range:                     self = .sliderControlRange
            
        // PancakeAudioLevelControl
        case PancakeAudioLevelControl.Selector.scalarValue:                self = .levelControlScalarValue
        case PancakeAudioLevelControl.Selector.decibelValue:               self = .levelControlDecibelValue
        case PancakeAudioLevelControl.Selector.decibelRange:               self = .levelControlDecibelRange
        case PancakeAudioLevelControl.Selector.convertScalarToDecibels:    self = .levelControlConvertScalarToDecibels
        case PancakeAudioLevelControl.Selector.convertDecibelsToScalar:    self = .levelControlConvertDecibelsToScalar
            
        // PancakeAudioBooleanControl
        case PancakeAudioBooleanControl.Selector.value:                    self = .booleanControlValue
            
        // PancakeAudioSelectorControl
        case PancakeAudioSelectorControl.Selector.currentItem:             self = .selectorControlCurrentItem
        case PancakeAudioSelectorControl.Selector.availableItems:          self = .selectorControlAvailableItems
        case PancakeAudioSelectorControl.Selector.itemName:                self = .selectorControlItemName
        case PancakeAudioSelectorControl.Selector.itemKind:                self = .selectorControlItemKind
            
        // PancakeAudioStereoPanControl
        case PancakeAudioStereoPanControl.Selector.value:                  self = .stereoPanControlValue
        case PancakeAudioStereoPanControl.Selector.panningChannels:        self = .stereoPanControlPanningChannels
            
        // From PancakeAudioServerPlugIn.h
        case PancakeAudioObject.Selector.customPropertyInfoList:           self = .objectCustomPropertyInfoList
        case PancakeAudioDevice.Selector.zeroTimeStampPeriod:              self = .deviceZeroTimeStampPeriod
        case PancakeAudioDevice.Selector.clockAlgorithm:                   self = .deviceClockAlgorithm
        case PancakeAudioDevice.Selector.clockIsStable:                    self = .deviceClockIsStable


        // Unknown property
        default:
            let text = String(fourCharCode: selector)
            assertionFailure("Selector '\(text)' not known.")
            return nil
        }
    }
}


// MARK: - Raw Value Accessor
extension PancakeAudioObjectPropertySelector {
    var rawValue: AudioObjectPropertySelector {
        switch self {
        // PancakeAudioObject
        case .objectBaseClass:                        return PancakeAudioObject.Selector.baseClass
        case .objectClass:                            return PancakeAudioObject.Selector.class
        case .objectOwner:                            return PancakeAudioObject.Selector.owner
        case .objectName:                             return PancakeAudioObject.Selector.name
        case .objectModelName:                        return PancakeAudioObject.Selector.modelName
        case .objectManufacturer:                     return PancakeAudioObject.Selector.manufacturer
        case .objectElementName:                      return PancakeAudioObject.Selector.elementName
        case .objectElementCategoryName:              return PancakeAudioObject.Selector.elementCategoryName
        case .objectElementNumberName:                return PancakeAudioObject.Selector.elementNumberName
        case .objectOwnedObjects:                     return PancakeAudioObject.Selector.ownedObjects
        case .objectIdentify:                         return PancakeAudioObject.Selector.identify
        case .objectSerialNumber:                     return PancakeAudioObject.Selector.serialNumber
        case .objectFirmwareVersion:                  return PancakeAudioObject.Selector.firmwareVersion
            
        // PancakeAudioPlugin
        case .pluginBundleID:                         return PancakeAudioPlugin.Selector.bundleID
        case .pluginDeviceList:                       return PancakeAudioPlugin.Selector.deviceList
        case .pluginTranslateUIDToDevice:             return PancakeAudioPlugin.Selector.translateUIDToDevice
        case .pluginBoxList:                          return PancakeAudioPlugin.Selector.boxList
        case .pluginTranslateUIDToBox:                return PancakeAudioPlugin.Selector.translateUIDToBox
        case .pluginClockDeviceList:                  return PancakeAudioPlugin.Selector.clockDeviceList
        case .pluginTranslateUIDToClockDevice:        return PancakeAudioPlugin.Selector.translateUIDToClockDevice
            
        // PancakeAudioTransportManager
        case .transportManagerEndPointList:           return PancakeAudioTransportManager.Selector.endPointList
        case .transportManagerTranslateUIDToEndPoint: return PancakeAudioTransportManager.Selector.translateUIDToEndPoint
        case .transportManagerTransportType:          return PancakeAudioTransportManager.Selector.transportType
            
        // PancakeAudioBox
        case .boxUID:                                 return PancakeAudioBox.Selector.boxUID
        case .boxTransportType:                       return PancakeAudioBox.Selector.transportType
        case .boxHasAudio:                            return PancakeAudioBox.Selector.hasAudio
        case .boxHasVideo:                            return PancakeAudioBox.Selector.hasVideo
        case .boxHasMIDI:                             return PancakeAudioBox.Selector.hasMIDI
        case .boxIsProtected:                         return PancakeAudioBox.Selector.isProtected
        case .boxAcquired:                            return PancakeAudioBox.Selector.acquired
        case .boxAcquisitionFailed:                   return PancakeAudioBox.Selector.acquisitionFailed
        case .boxDeviceList:                          return PancakeAudioBox.Selector.deviceList
        case .boxClockDeviceList:                     return PancakeAudioBox.Selector.clockDeviceList
            
        // PancakeAudioDevice
        case .deviceConfigurationApplication:         return PancakeAudioDevice.Selector.configurationApplication
        case .deviceUID:                              return PancakeAudioDevice.Selector.deviceUID
        case .deviceModelUID:                         return PancakeAudioDevice.Selector.modelUID
        case .deviceTransportType:                    return PancakeAudioDevice.Selector.transportType
        case .deviceRelatedDevices:                   return PancakeAudioDevice.Selector.relatedDevices
        case .deviceClockDomain:                      return PancakeAudioDevice.Selector.clockDomain
        case .deviceIsAlive:                          return PancakeAudioDevice.Selector.deviceIsAlive
        case .deviceIsRunning:                        return PancakeAudioDevice.Selector.deviceIsRunning
        case .deviceCanBeDefaultDevice:               return PancakeAudioDevice.Selector.deviceCanBeDefaultDevice
        case .deviceCanBeDefaultSystemDevice:         return PancakeAudioDevice.Selector.deviceCanBeDefaultSystemDevice
        case .deviceLatency:                          return PancakeAudioDevice.Selector.latency
        case .deviceStreams:                          return PancakeAudioDevice.Selector.streams
        case .deviceControlList:                      return PancakeAudioDevice.Selector.controlList
        case .deviceSafetyOffset:                     return PancakeAudioDevice.Selector.safetyOffset
        case .deviceNominalSampleRate:                return PancakeAudioDevice.Selector.nominalSampleRate
        case .deviceAvailableNominalSampleRates:      return PancakeAudioDevice.Selector.availableNominalSampleRates
        case .deviceIcon:                             return PancakeAudioDevice.Selector.icon
        case .deviceIsHidden:                         return PancakeAudioDevice.Selector.isHidden
        case .devicePreferredChannelsForStereo:       return PancakeAudioDevice.Selector.preferredChannelsForStereo
        case .devicePreferredChannelLayout:           return PancakeAudioDevice.Selector.preferredChannelLayout
            
        // PancakeAudioClockDevice
        case .clockDeviceUID:                         return PancakeAudioClockDevice.Selector.deviceUID
        case .clockDeviceTransportType:               return PancakeAudioClockDevice.Selector.transportType
        case .clockDeviceClockDomain:                 return PancakeAudioClockDevice.Selector.clockDomain
        case .clockDeviceIsAlive:                     return PancakeAudioClockDevice.Selector.deviceIsAlive
        case .clockDeviceIsRunning:                   return PancakeAudioClockDevice.Selector.deviceIsRunning
        case .clockDeviceLatency:                     return PancakeAudioClockDevice.Selector.latency
        case .clockDeviceControlList:                 return PancakeAudioClockDevice.Selector.controlList
        case .clockDeviceNominalSampleRate:           return PancakeAudioClockDevice.Selector.nominalSampleRate
        case .clockDeviceAvailableNominalSampleRates: return PancakeAudioClockDevice.Selector.availableNominalSampleRates
            
        // PancakeAudioEndPointDevice
        case .endPointDeviceComposition:              return PancakeAudioEndPointDevice.Selector.composition
        case .endPointDeviceEndPointList:             return PancakeAudioEndPointDevice.Selector.endPointList
        case .endPointDeviceIsPrivate:                return PancakeAudioEndPointDevice.Selector.isPrivate
            
        // PancakeAudioEndPoint
        case .streamIsActive:                         return PancakeAudioStream.Selector.isActive
        case .streamDirection:                        return PancakeAudioStream.Selector.direction
        case .streamTerminalType:                     return PancakeAudioStream.Selector.terminalType
        case .streamStartingChannel:                  return PancakeAudioStream.Selector.startingChannel
        case .streamLatency:                          return PancakeAudioStream.Selector.latency
        case .streamVirtualFormat:                    return PancakeAudioStream.Selector.virtualFormat
        case .streamAvailableVirtualFormats:          return PancakeAudioStream.Selector.availableVirtualFormats
        case .streamPhysicalFormat:                   return PancakeAudioStream.Selector.physicalFormat
        case .streamAvailablePhysicalFormats:         return PancakeAudioStream.Selector.availablePhysicalFormats
            
        // PancakeAudioControl
        case .controlScope:                           return PancakeAudioControl.Selector.scope
        case .controlElement:                         return PancakeAudioControl.Selector.element
            
        // PancakeAudioSliderControl
        case .sliderControlValue:                     return PancakeAudioSliderControl.Selector.value
        case .sliderControlRange:                     return PancakeAudioSliderControl.Selector.range
            
        // PancakeAudioLevelControl
        case .levelControlScalarValue:                return PancakeAudioLevelControl.Selector.scalarValue
        case .levelControlDecibelValue:               return PancakeAudioLevelControl.Selector.decibelValue
        case .levelControlDecibelRange:               return PancakeAudioLevelControl.Selector.decibelRange
        case .levelControlConvertScalarToDecibels:    return PancakeAudioLevelControl.Selector.convertScalarToDecibels
        case .levelControlConvertDecibelsToScalar:    return PancakeAudioLevelControl.Selector.convertDecibelsToScalar
            
        // PancakeAudioBooleanControl
        case .booleanControlValue:                    return PancakeAudioBooleanControl.Selector.value
            
        // PancakeAudioSelectorControl
        case .selectorControlCurrentItem:             return PancakeAudioSelectorControl.Selector.currentItem
        case .selectorControlAvailableItems:          return PancakeAudioSelectorControl.Selector.availableItems
        case .selectorControlItemName:                return PancakeAudioSelectorControl.Selector.itemName
        case .selectorControlItemKind:                return PancakeAudioSelectorControl.Selector.itemKind
            
        // PancakeAudioStereoPanControl
        case .stereoPanControlValue:                  return PancakeAudioStereoPanControl.Selector.value
        case .stereoPanControlPanningChannels:        return PancakeAudioStereoPanControl.Selector.panningChannels
        
            
        
        // From PancakeAudioServerPlugIn.h
        case .objectCustomPropertyInfoList:           return PancakeAudioObject.Selector.customPropertyInfoList
        case .deviceZeroTimeStampPeriod:              return PancakeAudioDevice.Selector.zeroTimeStampPeriod
        case .deviceClockAlgorithm:                   return PancakeAudioDevice.Selector.clockAlgorithm
        case .deviceClockIsStable:                    return PancakeAudioDevice.Selector.clockIsStable
        }
    }
}
