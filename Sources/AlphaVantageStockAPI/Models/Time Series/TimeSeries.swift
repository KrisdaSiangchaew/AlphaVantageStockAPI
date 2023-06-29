//
//  File.swift
//  
//
//  Created by Kris on 30/6/2566 BE.
//

import Foundation

public protocol TimeSeries {
    var metaData: MetaData? { get set }
    var quotes: [Quote] { get set }
    var error: DecodeError? { get set }
}
