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
    func setProperty(description: PancakeObjectPropertyDescription, data: UnsafeRawPointer) throws
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


protocol PancakeError: Error {}

struct PancakeObjectPropertyQueryError: PancakeError {
    let status: OSStatus
}
