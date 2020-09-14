//
//  LoginBusiness.swift
//  snowmanlabs
//
//  Created by douglas.nunes on 13/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit
import FirebaseDatabase

public class LoginBusiness {
    
    public init() {}
    private var ref: DatabaseReference!
    
    
    public func login(credential: AuthCredential, callback: @escaping (Callback<[Any]>) -> Void) {
        Auth.auth().signIn(with: credential) { [weak self] (result, error) in
            if (error != nil) {
                callback(Callback(error: error))
            } else {
                guard let uid = result?.user.uid else { return }
                self?.isRegistered(uid: uid, completion: { (result) in
                    if(!result) {
                        callback(Callback(error: error))
                        return
                    }
                    callback(Callback(result: result))
                })
            }
        }
    }
    
    public func signup(credential: AuthCredential, callback: @escaping (Callback<[Any]>) -> Void) {
        Auth.auth().signIn(with: credential) { [weak self] (result, error) in
            if (error != nil) {
                callback(Callback(error: error))
            } else {
                guard let uid = result?.user.uid, let email = result?.user.email, let name = result?.user.displayName else { return }
                self?.registerUser(uid: uid, email: email, name: name, completion:{ (result, err) in
                    if(result) {
                        callback(Callback(result: result))
                        return
                    }
                    callback(Callback(error: err))
                })
            }
        }
    }
    
    
    private func registerUser(uid: String, email: String, name: String, completion: @escaping (Bool , Error?)->()) {
        ref = Database.database().reference()
        ref.child("users").child(uid).setValue(["email": email, "name": name, "spots": []]) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
                completion(false, error)
            } else {
                print("Data saved successfully!")
                completion(true, error)
            }
        }
    }
    
    private func isRegistered(uid : String, completion: @escaping (Bool)->()) {
        ref = Database.database().reference()
        ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            completion(value != nil)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
