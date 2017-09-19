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
    private var lastID: AudioObjectID = 0
    private var storage: [AudioObjectID: PancakeObjectType] = [:]

    /// Initializes the instance.
    /// This makes sure the initial IDs and objects are set correctly. (e.g.
    ///
    /// - Parameter pancake: The pancake object to be used by all audio objects.
    func initialize(pancake: Pancake) {
        // IDs 0 and 1 are predefined (also see PancakeAudioObjectID):
        // - 0 is the 'unknown' ID, but will never be accessed,
        //     so we don't even add an object for it.
        // - 1 is the 'plugin' ID and has to be availiable from the beginning of
        //     the plugins lifetime.
        let pluginObject = PancakePlugin(pancake: pancake)
        pluginObject.objectID = PancakeAudioObjectID.plugin
        self.storage = [
            PancakeAudioObjectID.plugin: pluginObject
        ]
        self.lastID = PancakeAudioObjectID.plugin
    }
    
    /// Adds an object to the list and assigns it an ID.
    /// Note: The object is not allowed to have an ID already.
    ///
    /// - Parameter object: The object to be added to the list.
    /// - Returns: The ID the object got assigned.
    @discardableResult
    func add(object: PancakeObjectType) -> AudioObjectID {
        guard self.storage.count > 0 else { fatalError("This list was never initialized.") }
        guard object.objectID == nil else { fatalError("The object you're trying to add has an ID already.") }
        guard self.lastID < AudioObjectID.max else { fatalError("We're out of IDs.") }
        self.lastID += 1
        self.storage[self.lastID] = object
        object.objectID = self.lastID
        return self.lastID
    }
    
    /// Convenience method for adding multiple objects to the list
    /// (and assigning them IDs) all at once.
    ///
    /// - Parameter objects: The objects to be added to the list.
    func add(_ objects: PancakeObjectType ...) {
        objects.forEach {
            self.add(object: $0)
        }
    }
    
    /// Finds all object of a given type in the list and returns their IDs.
    ///
    /// - Parameter expectedType: The type to be found.
    /// - Returns: The list of IDs.
    func IDsForObjects<T: PancakeObjectType>(of expectedType: T.Type) -> [AudioObjectID] {
        let matchingEntries = self.storage.filter { (ID: AudioObjectID, object: PancakeObjectType) -> Bool in
            return type(of: object) == expectedType
        }
        let matchingIDs = matchingEntries.map { (ID: AudioObjectID, object: PancakeObjectType) in return ID }
        return matchingIDs
    }
    
    /// An accessor to easily get objects from the list via subscript
    /// notation, e.g. `audioObjectList[12]`.
    ///
    /// - Parameter index: The object which has the ID or nil.
    subscript(index: AudioObjectID) -> PancakeObjectType? {
        guard let element = self.storage[index] else {
            assertionFailure()
            return nil
        }
        return element
    }
}

