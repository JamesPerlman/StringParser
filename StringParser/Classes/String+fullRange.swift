//
//  String+fullRange.swift
//  StringDestructurer
//
//  Created by James Perlman on 3/13/17.
//  Copyright © 2017 James Perlman. All rights reserved.
//

import Foundation

extension String {
    internal var fullRange: Range<String.Index> {
        return Range(uncheckedBounds: (startIndex, endIndex))
    }
}
