//
//  GenericTokenCollection.swift
//  Pods
//
//  Created by James Perlman on 3/13/17.
//
//

import Foundation

// question: LazyCollectionProtocol? or not lazy?  why?
public struct GenericTokenCollection: Collection
{
    public subscript(position: Int) -> String
    {
        return "$\(position)"
    }
    
    public var startIndex = 0
    public var endIndex = Int.max
    
    public func index(after i: Int) -> Int
    {
        return i + 1
    }
}
