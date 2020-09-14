//
//  AddSpotViewModel.swift
//  snowmanlabs
//
//  Created by douglas.nunes on 14/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import Firebase

final class AddSpotViewModel {
    private let spotBusiness: SpotBusiness = SpotBusiness()
    var completion: (AddSpotState) -> Void = { _ in }
    
    enum AddSpotState {
        case failure(String)
        case success
    }

    func createSpot() {
        
    }
    
    
}
