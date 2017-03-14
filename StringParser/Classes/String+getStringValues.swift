//
//  String+getStringValues.swift
//  StringParser
//
//  Created by James Perlman on 3/13/17.
//  Copyright © 2017 James Perlman. All rights reserved.
//

import Foundation

extension String {
    // need https://lists.swift.org/pipermail/swift-evolution/Week-of-Mon-20170123/030675.html
    // default T = String
    internal func getValue<T: Parseable>(of token: String, from template: String) throws -> T
    {
        let target = self
        
        // get the range of the token we are searching for
        guard let tokenRange = template.range(of: token)
            else { throw ParseError.tokenNotFound(token, template) }
        
        
        // get the substring of the template before the token
        let templatePrefix = template.substring(to: tokenRange.lowerBound)
        
        // make sure the line (target.substring...) won't raise an exception
        guard tokenRange.overlaps(target.fullRange)
            else { throw ParseError.badTemplate }
        
        // get the substring in the target before the spot where the token should be
        let targetPrefix = target.substring(to: tokenRange.lowerBound)
        
        // make sure the template prefix matches the target prefix
        guard targetPrefix == templatePrefix
            else { throw ParseError.badTemplate }
        
        // get the substring in the template after the token
        let templateSuffixRange = Range(uncheckedBounds: (tokenRange.upperBound, template.endIndex))
        
        
        let targetSuffixRange: Range<String.Index>
        
        // If the template suffix range is empty, then the suffix is just an empty string at the end of the template
        if templateSuffixRange.isEmpty
        {
            // Set the target suffix range to be an empty range at the end of the template
            targetSuffixRange = Range(uncheckedBounds: (target.endIndex, target.endIndex))
        }
        else
        {
            
            // template suffix range is not empty
            let templateSuffix = template.substring(with: templateSuffixRange)
            
            // we need to find the last occurrence of templateSuffix in the target string
            guard let range = target.range(of: templateSuffix, options: String.CompareOptions.backwards)
                else { throw ParseError.badTemplate }
            
            targetSuffixRange = range
        }
        // Make sure suffixes match between template and target?
        
        // get the value of the token from the target based on the template
        let targetInfixRange = Range(uncheckedBounds: (tokenRange.lowerBound, targetSuffixRange.lowerBound))
        let targetValueString = target.substring(with: targetInfixRange)
        
        guard let value = T(string: targetValueString)
            else { throw ParseError.conversionFailure(targetValueString, T.self) }
        
        return value
    }
    
    internal func getStringValues(from template: String, count numTokens: Int) throws -> [String]
    {
        return try getStringValues(of: [Int](0...numTokens-1).map { "$\($0)" }, from: template)
    }
    
    internal func getStringValues(of tokens: [String], from template: String, collectedValues: [String] = []) throws -> [String]
    {
        let target = self
        
        print("tokens = " + tokens.joined(separator: ","))
        // if there are no tokens left, we can return the collected values
        guard let token = tokens.first
            else { return collectedValues }
        
        // otherwise we must extract the value based on the template!
        let templateSections: [String] // we will split the template into sections using an array.  The first item will be the section of the string we are token-testing right now, and the second section (if there is one) will be the remainder of the string.
        let nextToken: String
        
        // look ahead for next token.  if it exists, we will only be checking a section of the template
        if tokens.count > 1 {
            // get the next token
            nextToken = tokens[1]
            // and make sure it exists in the template string
            guard let nextTokenRange = template.range(of: nextToken)
                else { throw ParseError.tokenNotFound(nextToken, template) }
            
            // use the section of the template between the start of the template and the start of the next token
            let sectionRange = Range(uncheckedBounds: (template.startIndex, nextTokenRange.lowerBound))
            templateSections = [template.substring(with: sectionRange), template.substring(from: sectionRange.upperBound)]
            
        } else {
            // otherwise this is the last token, so we just use the whole template
            templateSections = [template]
            nextToken = ""
        }
        
        // split template into pieces before and after token
        let templatePieces = templateSections[0].components(separatedBy: token)
        
        // If there aren't exactly two pieces, then the template is malformed
        guard templatePieces.count == 2
            else { throw ParseError.badTemplate }
        // prepare for tail-recursion (it's safe!)
        
        // get the value of this token in the target based on the template
        // TODO: Inline getValue here? (so we can get useful Range info about the target string without redundant code)
        let stringValue:String = try getValue(of: token, from: templateSections[0])
        
        // new target is the remainder of the current target after the end index of the parsed value
        guard let tokenRange = template.range(of: token)
            else { throw ParseError.tokenNotFound(token, template) }
        // this is redundant and one solution is to inline getValue
        // that would also save processor power because we just want a string
        
        // new tokens param is just the current tokens param excluding the first token
        let newTokens = Array(tokens.dropFirst())
        
        // new template is the remainder of the current template from after the current token
        let newTemplate = template.substring(from: tokenRange.upperBound)
        
        let collectedValues = collectedValues + [stringValue]
        
        // TODO: I think technically this is incorrect index math although it will work
        let newTarget = target.substring(from: target.index(tokenRange.lowerBound, offsetBy: stringValue.characters.count))
        return try newTarget.getStringValues(of: newTokens, from: newTemplate, collectedValues: collectedValues)
        
    }
}
