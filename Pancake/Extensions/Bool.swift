//
//  Bool.swift
//  Pancake
//
//  Created by mxa on 16.05.2018.
//  Copyright © 2018 0bmxa. All rights reserved.
//

extension Bool {
    init(_ darwinBoolean: DarwinBoolean) {
        self = darwinBoolean.boolValue
    }
}
