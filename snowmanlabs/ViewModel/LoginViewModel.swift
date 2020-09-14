//
//  LoginViewModel.swift
//  snowmanlabs
//
//  Created by douglas.nunes on 13/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import Firebase

final class LoginViewModel {
    private let loginBusiness: LoginBusiness = LoginBusiness()
    var completion: (LoginState) -> Void = { _ in }
    
    enum LoginState {
        case failure(String)
        case failureRegister(String)
        case success
        case successRegister
    }
    
    func login(view: UIViewController) {
        LoginManager().logIn(permissions: ["email", "public_profile"], from: view) { [weak self] (result, error) in
            if error != nil {
                self?.completion(.failure(error?.localizedDescription ?? ""))
            }
            guard let accessToken = result?.token?.tokenString else { return }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
            self?.loginBusiness.login(credential: credential) { [weak self] result in
                if result.result != nil {
                    self?.completion(.success)
                } else {
                    LoginManager().logOut()
                    self?.completion(.failure("User not registered"))
                }
            }
        }
    }
    
    
    func signup(view: UIViewController) {
        LoginManager().logIn(permissions: ["email", "public_profile"], from: view) { [weak self] (result, error) in
               if error != nil {
                   self?.completion(.failure(error?.localizedDescription ?? ""))
               }
               guard let accessToken = result?.token?.tokenString else { return }
               let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
               self?.loginBusiness.signup(credential: credential) { [weak self] result in
                   if result.result != nil {
                    self?.completion(.successRegister)
                   } else {
                       LoginManager().logOut()
                       self?.completion(.failureRegister("User register error"))
                   }
               }
           }
    }
    
}
