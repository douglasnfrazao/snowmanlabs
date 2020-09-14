//
//  SpotBusiness.swift
//  snowmanlabs
//
//  Created by do on 14/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit
import FirebaseDatabase

public class SpotBusiness {
    
    public init() {}
    private var ref: DatabaseReference!

    public func createSpot(name: String, completion: @escaping (Bool, Error?)->()) {
        ref = Database.database().reference()
        ref.child("spot").setValue(["name": name]) {
          (error:Error?, ref:DatabaseReference) in
          if let error = error {
            completion(false, error)
          } else {
            completion(true, error)
          }
        }
    }
}
