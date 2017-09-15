//
//  AudioObjectList.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio

/// A wrapper around a dictionary that stores all instances of AudioObjects
/// created by Pancake. It's also responsible for instantiating new objects, as
/// it's the only one that knows which IDs are available.
class PancakeAudioObjectList {
    private var pancake: Pancake?
    
    private var lastID: AudioObjectID = 0
    private var storage: [AudioObjectID: PancakeObjectType] = [:]

    /// Initializes the instance.
    /// Like a regular init(), but called later.
    ///
    /// - Parameter pancake: The pancake object to be used by all audio objects.
    func initialize(pancake: Pancake) {
        self.pancake = pancake
        self.storage = [
            PancakeAudioObjectID.unknown: PancakeBaseObject(objectID: PancakeAudioObjectID.unknown, pancake: pancake),
            PancakeAudioObjectID.plugin: PancakePlugin(objectID: PancakeAudioObjectID.plugin, pancake: pancake)
        ]
        self.lastID = PancakeAudioObjectID.plugin
    }
    
    /// Creates a new instance of a PancakeObjectType and adds it to the list.
    ///
    /// - Parameter type: The type of the object to be instantiated.
    /// - Returns: The ID of the newly created object.
    @discardableResult
    func createObject(type: PancakeObjectType.Type) -> AudioObjectID {
        guard let pancake = self.pancake, self.storage.count > 1 else {
            fatalError("This list was never initialized. Please call `yourAudioObjectList.initialize(pancake:)` first before adding objects to it.")
        }
        guard self.lastID < AudioObjectID.max else { fatalError("We're out of IDs.") }
        self.lastID += 1
        let instance = type.init(objectID: self.lastID, pancake: pancake)
        self.storage[self.lastID] = instance
        return self.lastID
    }
    
    /// Finds all object of a given type in the list and returns their IDs.
    ///
    /// - Parameter expectedType: The type to be found.
    /// - Returns: The list of IDs.
    func allObjectIDs<T: PancakeObjectType>(type expectedType: T.Type) -> [AudioObjectID] {
        let matchingEntries = self.storage.filter { (ID: AudioObjectID, object: PancakeObjectType) -> Bool in
            return type(of: object) == expectedType
        }
        let matchingIDs = matchingEntries.map { (ID: AudioObjectID, object: PancakeObjectType) in return ID }
        return matchingIDs
    }
    
    /// A subscript accessor to get objects from the list with subscript
    /// notation, e.g. `audioObjectList[12]`.
    ///
    /// - Parameter index: The object which has the ID or nil.
    subscript(index: AudioObjectID) -> PancakeObjectType? {
        guard let element = self.storage[index] else { return nil }
        return element
    }
}

