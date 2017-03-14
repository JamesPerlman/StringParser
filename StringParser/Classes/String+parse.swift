//
//  String+parse.swift
//  Pods
//
//  Created by James Perlman on 3/13/17.
//
//

import Foundation

public extension String {
    func parse<A: Parseable>(_ template: String) throws -> (A)
    {
        let values = try getStringValues(from: template, count: 1)
        
        guard let a = A(string: values[0])
            else { throw ParseError.conversionFailure(values[0], A.self) }

        return (a)
    }
    
    func parse<A: Parseable, B: Parseable>(_ template: String) throws -> (A, B)
    {
        let values = try getStringValues(from: template, count: 2)
        
        guard let a = A(string: values[0])
            else { throw ParseError.conversionFailure(values[0], A.self) }
        
        guard let b = B(string: values[1])
            else { throw ParseError.conversionFailure(values[1], A.self) }
        
        return (a, b)
    }
    
    func parse<A: Parseable, B: Parseable, C: Parseable>(_ template: String) throws -> (A, B, C)
    {
        let values = try getStringValues(from: template, count: 3)
        
        guard let a = A(string: values[0])
            else { throw ParseError.conversionFailure(values[0], A.self) }
        
        guard let b = B(string: values[1])
            else { throw ParseError.conversionFailure(values[1], A.self) }
        
        guard let c = C(string: values[2])
            else { throw ParseError.conversionFailure(values[2], A.self) }
        
        return (a, b, c)
    }
}
