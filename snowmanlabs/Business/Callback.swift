//
//  Callback.swift
//  snowmanlabs
//
//  Created by douglas.nunes on 13/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import Foundation

public struct Unknow: Decodable {
}

public class Callback<D: Any> {
    
    public var result: Any?
    public var error: Swift.Error?
    public var data: D?
    
    public init(result: Any? = nil, error: Swift.Error? = nil) {
        self.result = result
        self.error = error
        self.validate()
    }
    
    public func validate() {
        if error != nil {
            return
        }
        if let result = result,
            type(of: result) == D.self {
            data = result as? D
            return
        }
        error = NSError(domain: "", code: -10, userInfo: nil)
    }
}
