//
//  PancakeObjectPropertyDescription.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio

typealias PancakeAudioObjectPropertyAddress = PancakeObjectPropertyDescription
struct PancakeObjectPropertyDescription {
    let selector: PancakeAudioObjectPropertySelector
    let scope:    PancakeAudioObjectPropertyScope
    let element:  PancakeAudioObjectPropertyElement
    
    init?(with address: AudioObjectPropertyAddress) {
        guard
            let selector = PancakeAudioObjectPropertySelector(rawValue: address.mSelector),
            let scope    = PancakeAudioObjectPropertyScope(rawValue: address.mScope)
            else {
                assertionFailure()
                return nil
        }
        let element  = PancakeAudioObjectPropertyElement(rawValue: address.mElement)
        
        self.selector = selector
        self.scope    = scope
        self.element  = element
    }
}
