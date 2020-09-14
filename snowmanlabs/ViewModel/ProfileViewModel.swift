//
//  ProfileViewModel.swift
//  snowmanlabs
//
//  Created by douglas.nunes on 14/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import FBSDKLoginKit
import Firebase


struct User {
    var name: String
    var email: String
    var photo: URL
}

final class ProfileViewModel {
    var completion: (ProfileState) -> Void = { _ in }
    
    enum ProfileState {
        case failure(String)
        case success
    }
    
    func logout() {
         LoginManager().logOut()
         Router.login()
     }
    
    func getProfile() -> User {
        guard let name = Auth.auth().currentUser?.displayName,
            let email = Auth.auth().currentUser?.email,
            let photo = Auth.auth().currentUser?.photoURL else { return User(name: "Username", email: "email", photo: URL(fileURLWithPath: "")) }
        return User(name: name, email: email, photo: photo)
    }
    
}

