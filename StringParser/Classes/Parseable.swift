//
//  Parseable.swift
//  StringDestructurer
//
//  Created by James Perlman on 3/13/17.
//  Copyright © 2017 James Perlman. All rights reserved.
//

import Foundation

public protocol Parseable {
    init?(string: String)
}


/** Foundation type extensions for Parseable **/

extension Int: Parseable {
    public init?(string: String) {
        self.init(string)
    }
}

extension String: Parseable {
    public init?(string: String) {
        self.init(string)
    }
}

extension Float: Parseable {
    public init?(string: String) {
        self.init(string)
    }
}

extension Double: Parseable {
    public init?(string: String) {
        self.init(string)
    }
}

extension Bool: Parseable {
    public init?(string: String) {
        self.init(string)
    }
}



/** Need this feature: https://lists.swift.org/pipermail/swift-evolution/Week-of-Mon-20160926/027300.html
extension RawRepresentable: Parseable where RawValue == String {
    public init?(string: String) {
        self.init(rawValue: string)
    }
}*/
