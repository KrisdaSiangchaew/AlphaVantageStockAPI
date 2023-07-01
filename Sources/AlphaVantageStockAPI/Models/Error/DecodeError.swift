//
//  File.swift
//  
//
//  Created by Kris on 29/6/2566 BE.
//

import Foundation

public enum DecodeError: Error, RawRepresentable {
    case error(String)
    case information(String)
    
    public var rawValue: String {
        switch self {
        case .error(let message):
            return message
        case .information(let message):
            return message
        }
    }
    
    public init?(rawValue: String) {
        self = .error(rawValue)
        self = .information(rawValue)
    }
}
