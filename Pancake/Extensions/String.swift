//
//  String.swift
//  Pancake
//
//  Created by mxa on 07.12.2017.
//  Copyright © 2017 0bmxa. All rights reserved.
//

import Foundation

extension String {
    func prefix(to indexVal: Int) -> String? {
        guard indexVal >= 0, indexVal < self.count else { return nil }
        let index = self.index(self.startIndex, offsetBy: indexVal)
        return String(self[..<index])
    }

    func suffix(from indexVal: Int) -> String? {
        guard indexVal >= 0, indexVal < self.count else { return nil }
        let index = self.index(self.startIndex, offsetBy: indexVal)
        return String(self[index...])
    }
}
