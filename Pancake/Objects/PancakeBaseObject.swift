//
//  PancakeBaseObject.swift
//  Pancake
//
//  Created by mxa on 14.09.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import CoreAudio.AudioServerPlugIn

//class PancakeBaseObject: PancakeObjectType {
//    internal var objectID: AudioObjectID? = nil
//    private let pancake: Pancake
//    
//    required init(pancake: Pancake) {
//        self.pancake = pancake
//    }
//    
//    
//    func getProperty(description: PancakeObjectPropertyDescription, sizeHint: UInt32?) throws -> PancakeObjectProperty {
//        printcake(#function, description.selector)
//        
//        switch description.selector {
////        case .objectOwnedObjects:
////            fatalError()
////
////        case .objectName, .objectModelName, .objectElementName:
////            fatalError()
////
////        case .deviceUID:
////            try assure(CFString.self, fitsIn: sizeHint)
////            return .string("Pancake Device" as CFString)
////
////        case .boxUID:
////            try assure(CFString.self, fitsIn: sizeHint)
////            return .string("Pancake Box" as CFString)
//            
//        default:
//            printcake("Not implemented:", description.selector)
//            assertionFailure()
//            throw PancakeObjectPropertyQueryError(status: PancakeAudioHardwareError.unknownProperty)
//        }
//    }
//}

