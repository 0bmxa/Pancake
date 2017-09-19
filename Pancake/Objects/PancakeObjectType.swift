//
//  PancakeObject.swift
//  Pancake
//
//  Created by mxa on 29.08.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

protocol PancakeObjectType: class {
    var objectID: AudioObjectID? { get set }
    
    func hasProperty(description: PancakeObjectPropertyDescription) -> Bool
    func getProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty
}

extension PancakeObjectType {
    func hasProperty(description: PancakeObjectPropertyDescription) -> Bool {
        do {
            _ = try self.getProperty(description: description, sizeHint: nil)
        } catch {
            //assertionFailure()
            return false
        }
        return true
    }
}




// =============================================================================
// =============================================================================
// =============================================================================



protocol PancakeError: Error {}

struct PancakeObjectPropertyQueryError: PancakeError {
    let status: OSStatus
}



//enum PancakeObjectID: AudioObjectID {
//    case unknown                = 0 // = PancakeAudioObjectID.unknown
//    case plugin                 = 1 // = PancakeAudioObjectID.plugin
//    case box                    = 2
//    case device                 = 3
//    case streamInput            = 4
//    case volumeInputMaster      = 5
//    case muteInputMaster        = 6
//    case dataSourceInputMaster  = 7
//    case streamOutput           = 8
//    case volumeOutputMaster     = 9
//    case muteOutputMaster       = 10
//    case dataSourceOutputMaster = 11
//}

