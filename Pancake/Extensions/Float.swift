//
//  Float.swift
//  Pancake
//
//  Created by mxa on 02.10.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import Foundation

extension FloatingPoint {
    func clampedTo(min minValue: Self, max maxValue: Self) -> Self {
        return min(maxValue, max(minValue, self))
    }

    mutating func clampTo(min minValue: Self, max maxValue: Self) {
        self = self.clampedTo(min: minValue, max: maxValue)
    }
}
