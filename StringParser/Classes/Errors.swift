//
//  Errors.swift
//  Pods
//
//  Created by James Perlman on 3/13/17.
//
//

import Foundation

enum ParseError: Error {
    case tokenNotFound(String, String)
    case conversionFailure(String, Any.Type)
    case badTemplate
    case impossible
}
